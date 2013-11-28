From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 0/2] serial: sh-sci: Prepare for CCF migration
Date: Thu, 28 Nov 2013 18:11:44 +0100
Message-ID: <1385658706-20093-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>
List-Id: linux-serial@vger.kernel.org

Hello,

This patch set prepares the driver to CCF migration by replacing clk_enable()
and clk_disable() by clk_prepare_enable() and clk_disable_unprepare()
respectively (2/2). In order to do so it first ensures that the clk_enable()
and clk_disable() calls will only take place from non-atomic context (1/2).

Greg, these patches are dependencies for a bunch of ARM patches that will go
through Simon's tree. Would you be fine if Simon merged all sh-sci patches
through his tree for v3.14 ?

Laurent Pinchart (2):
  serial: sh-sci: Don't enable/disable port from within break timer
  serial: sh-sci: Convert to clk_prepare/unprepare

 drivers/tty/serial/sh-sci.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

-- 
Regards,

Laurent Pinchart

