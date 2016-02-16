From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v4 07/12] Documentation: dt: Tidy up the Marvell related files
Date: Tue, 16 Feb 2016 19:14:57 +0100
Message-ID: <1455646502-23834-8-git-send-email-gregory.clement@free-electrons.com>
References: <1455646502-23834-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455646502-23834-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, arm@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Omri Itach <omrii@marvell.com>
List-Id: linux-serial@vger.kernel.org

Over the last releases we have added more and more Marvell related binding
directly in the arm directory. It's time to have our proper directory
inside it, and move all the files in it.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/{ => marvell}/armada-370-xp-pmsu.txt          | 0
 Documentation/devicetree/bindings/arm/{ => marvell}/armada-370-xp.txt     | 0
 Documentation/devicetree/bindings/arm/{ => marvell}/armada-375.txt        | 0
 .../devicetree/bindings/arm/{ => marvell}/armada-380-mpcore-soc-ctrl.txt  | 0
 Documentation/devicetree/bindings/arm/{ => marvell}/armada-38x.txt        | 0
 Documentation/devicetree/bindings/arm/{ => marvell}/armada-39x.txt        | 0
 Documentation/devicetree/bindings/arm/{ => marvell}/armada-cpu-reset.txt  | 0
 Documentation/devicetree/bindings/arm/{ => marvell}/coherency-fabric.txt  | 0
 Documentation/devicetree/bindings/arm/{ => marvell}/kirkwood.txt          | 0
 Documentation/devicetree/bindings/arm/{ => marvell}/marvell,berlin.txt    | 0
 Documentation/devicetree/bindings/arm/{ => marvell}/marvell,dove.txt      | 0
 Documentation/devicetree/bindings/arm/{ => marvell}/marvell,kirkwood.txt  | 0
 Documentation/devicetree/bindings/arm/{ => marvell}/mvebu-cpu-config.txt  | 0
 .../devicetree/bindings/arm/{ => marvell}/mvebu-system-controller.txt     | 0
 14 files changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/armada-370-xp-pmsu.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/armada-370-xp.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/armada-375.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/armada-380-mpcore-soc-ctrl.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/armada-38x.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/armada-39x.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/armada-cpu-reset.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/coherency-fabric.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/kirkwood.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/marvell,berlin.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/marvell,dove.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/marvell,kirkwood.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/mvebu-cpu-config.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/mvebu-system-controller.txt (100%)

diff --git a/Documentation/devicetree/bindings/arm/armada-370-xp-pmsu.txt b/Documentation/devicetree/bindings/arm/marvell/armada-370-xp-pmsu.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/armada-370-xp-pmsu.txt
rename to Documentation/devicetree/bindings/arm/marvell/armada-370-xp-pmsu.txt
diff --git a/Documentation/devicetree/bindings/arm/armada-370-xp.txt b/Documentation/devicetree/bindings/arm/marvell/armada-370-xp.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/armada-370-xp.txt
rename to Documentation/devicetree/bindings/arm/marvell/armada-370-xp.txt
diff --git a/Documentation/devicetree/bindings/arm/armada-375.txt b/Documentation/devicetree/bindings/arm/marvell/armada-375.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/armada-375.txt
rename to Documentation/devicetree/bindings/arm/marvell/armada-375.txt
diff --git a/Documentation/devicetree/bindings/arm/armada-380-mpcore-soc-ctrl.txt b/Documentation/devicetree/bindings/arm/marvell/armada-380-mpcore-soc-ctrl.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/armada-380-mpcore-soc-ctrl.txt
rename to Documentation/devicetree/bindings/arm/marvell/armada-380-mpcore-soc-ctrl.txt
diff --git a/Documentation/devicetree/bindings/arm/armada-38x.txt b/Documentation/devicetree/bindings/arm/marvell/armada-38x.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/armada-38x.txt
rename to Documentation/devicetree/bindings/arm/marvell/armada-38x.txt
diff --git a/Documentation/devicetree/bindings/arm/armada-39x.txt b/Documentation/devicetree/bindings/arm/marvell/armada-39x.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/armada-39x.txt
rename to Documentation/devicetree/bindings/arm/marvell/armada-39x.txt
diff --git a/Documentation/devicetree/bindings/arm/armada-cpu-reset.txt b/Documentation/devicetree/bindings/arm/marvell/armada-cpu-reset.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/armada-cpu-reset.txt
rename to Documentation/devicetree/bindings/arm/marvell/armada-cpu-reset.txt
diff --git a/Documentation/devicetree/bindings/arm/coherency-fabric.txt b/Documentation/devicetree/bindings/arm/marvell/coherency-fabric.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/coherency-fabric.txt
rename to Documentation/devicetree/bindings/arm/marvell/coherency-fabric.txt
diff --git a/Documentation/devicetree/bindings/arm/kirkwood.txt b/Documentation/devicetree/bindings/arm/marvell/kirkwood.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/kirkwood.txt
rename to Documentation/devicetree/bindings/arm/marvell/kirkwood.txt
diff --git a/Documentation/devicetree/bindings/arm/marvell,berlin.txt b/Documentation/devicetree/bindings/arm/marvell/marvell,berlin.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/marvell,berlin.txt
rename to Documentation/devicetree/bindings/arm/marvell/marvell,berlin.txt
diff --git a/Documentation/devicetree/bindings/arm/marvell,dove.txt b/Documentation/devicetree/bindings/arm/marvell/marvell,dove.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/marvell,dove.txt
rename to Documentation/devicetree/bindings/arm/marvell/marvell,dove.txt
diff --git a/Documentation/devicetree/bindings/arm/marvell,kirkwood.txt b/Documentation/devicetree/bindings/arm/marvell/marvell,kirkwood.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/marvell,kirkwood.txt
rename to Documentation/devicetree/bindings/arm/marvell/marvell,kirkwood.txt
diff --git a/Documentation/devicetree/bindings/arm/mvebu-cpu-config.txt b/Documentation/devicetree/bindings/arm/marvell/mvebu-cpu-config.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/mvebu-cpu-config.txt
rename to Documentation/devicetree/bindings/arm/marvell/mvebu-cpu-config.txt
diff --git a/Documentation/devicetree/bindings/arm/mvebu-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/mvebu-system-controller.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/mvebu-system-controller.txt
rename to Documentation/devicetree/bindings/arm/marvell/mvebu-system-controller.txt
-- 
2.5.0
