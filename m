From: Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH 0/2] dt-bindings: serial: lantiq: Convert to YAML & add support for new SoC
Date: Wed, 14 Aug 2019 16:22:33 +0800
Message-ID: <cover.1565770074.git.rahul.tanwar@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com, qi-ming.wu@intel.com, cheol.yong.kim@intel.com, rahul.tanwar@intel.com, Rahul Tanwar <rahul.tanwar@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

Patch 1 converts existing dt bindings txt file to YAML schema.

Patch 2 updates the dt bindings YAML contents to add support for newly supported
Intel Lightning Mountain(LGM) SoC.

These patches are baselined upon Linux 5.3-rc4 at below Git tree:
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git

Rahul Tanwar (2):
  dt-bindings: serial: lantiq: Convert to YAML schema
  dt-bindings: lantiq: Update for new SoC

 .../devicetree/bindings/serial/lantiq_asc.txt      | 31 --------
 .../devicetree/bindings/serial/lantiq_asc.yaml     | 87 ++++++++++++++++++++++
 2 files changed, 87 insertions(+), 31 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/lantiq_asc.txt
 create mode 100644 Documentation/devicetree/bindings/serial/lantiq_asc.yaml

-- 
2.11.0
