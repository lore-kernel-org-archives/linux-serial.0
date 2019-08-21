From: Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v3 0/2] dt-bindings: serial: lantiq: Convert to YAML & add support for new SoC
Date: Wed, 21 Aug 2019 15:06:50 +0800
Message-ID: <cover.1566370151.git.rahul.tanwar@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, devicetree@vger.kernel.org, gregkh@linuxfoundation.org, mark.rutland@arm.com, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com, qi-ming.wu@intel.com, cheol.yong.kim@intel.com, rahul.tanwar@intel.com, Rahul Tanwar <rahul.tanwar@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

There is a new product which reuses Lantiq serial controller IP. Patch 1 in this
series converts existing lantiq dt bindings to YAML schema and Patch 2 updates
it to support newer product.

These patches are baselined upon Linux 5.3-rc4 at below Git tree:
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git

v3:
* Use compatible name for filename.
* Use if/then schema to describe a property which is different for each
  compatibles.
* Address other review concerns about YAML format.

v2:
* Update license to GPL-2.0-only.
* Fix trailing whitespace error.


Rahul Tanwar (2):
  dt-bindings: serial: lantiq: Convert to YAML schema
  dt-bindings: lantiq: Update for new SoC

 .../devicetree/bindings/serial/lantiq,asc.yaml     | 90 ++++++++++++++++++++++
 .../devicetree/bindings/serial/lantiq_asc.txt      | 31 --------
 2 files changed, 90 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/lantiq,asc.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/lantiq_asc.txt

-- 
2.11.0
