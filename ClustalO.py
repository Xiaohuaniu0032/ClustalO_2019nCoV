#!/usr/bin/env python

# Copyright (C) 2019 Thermo Fisher Scientific. All Rights Reserved

import glob
import sys
import subprocess
import json
import os
import re
import shutil
from ion.plugin import *
from django.utils.functional import cached_property
from django.conf import settings
from django.template.loader import render_to_string




class ClustalO(IonPlugin):
  version  = '1.0.0.0'
  author   = "longfei.fu@thermofisher.com"
  date     = "2022-5-6"
  runtypes = [RunType.FULLCHIP, RunType.THUMB, RunType.COMPOSITE]

  # a simple cached version of the start plugin property
  @cached_property
  def startplugin_json(self):
    return self.startplugin

  def align(self):
    plugin_result_dir = self.startplugin_json['runinfo']['plugin'].get('results_dir')
    cons_dir  = self.startplugin_json['pluginconfig'].get('variant_caller_path')
    cons_name = os.path.basename(cons_dir) # generateConsensus_out.xxx
    
    abs_path = os.path.abspath(__file__)
    this_dir = os.path.dirname(abs_path)
    
    print "input cons dir is: %s" % (cons_dir)
    print "output dir is: %s" % (plugin_result_dir)

    cmd = "perl %s/ClustalO_pipeline.pl %s %s" (this_dir,cons_dir,plugin_result_dir)
    print "cmd is: %s" % (cmd)
    print "Start align..."
    os.system(cmd)


  def launch(self,data=None):
    self.align()
    print "Finished align..."

    with open("ClustalO_block.html","w") as f:
      f.write('<html><body>Click link to see ClustalO alignment result<br>\n')
      for aln in glob.glob('*.ClustalO.fasta'):
        print(aln)
        f.write('<a href="%s">%s</a><br>\n'
              % (os.path.join(net_location,url_path,aln),aln))
        f.write('</body></html>')
    
    return True


if __name__ == "__main__":
    PluginCLI()
