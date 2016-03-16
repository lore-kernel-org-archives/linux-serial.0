From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH 0/4] ARM: dts: r8a777[89]: HSCIF support
Date: Wed, 16 Mar 2016 18:10:06 +0100
Message-ID: <1458148210-21800-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: horms@verge.net.au
Cc: linux-renesas-soc@vger.kernel.org, linux-serial@vger.kernel.org, magnus.damm@gmail.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi!

This adds HSCIF nodes to the r8a7778 and r8a7779 device trees.
(And the relevant clocks on r8a7778, which are already there on r8a7779.)

CU
Uli


Ulrich Hecht (4):
  ARM: dts: r8a7778: Add HSCIF0/1 clocks
  ARM: dts: r8a7778: Add HSCIF0/1 device nodes
  ARM: dts: r8a7779: Add HSCIF0/1 device nodes
  serial: sh-sci: add r8a7778/9 HSCIF DT bindings

 .../bindings/serial/renesas,sci-serial.txt         |  2 ++
 arch/arm/boot/dts/r8a7778.dtsi                     | 30 ++++++++++++++++++++++
 arch/arm/boot/dts/r8a7779.dtsi                     | 26 +++++++++++++++++++
 include/dt-bindings/clock/r8a7778-clock.h          |  2 ++
 4 files changed, 60 insertions(+)

-- 
2.6.4
