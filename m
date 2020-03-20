Return-Path: <SRS0=zA/y=5F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE64C4332D
	for <linux-serial@archiver.kernel.org>; Fri, 20 Mar 2020 17:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E46F20773
	for <linux-serial@archiver.kernel.org>; Fri, 20 Mar 2020 17:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgCTRlP (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 20 Mar 2020 13:41:15 -0400
Received: from v6.sk ([167.172.42.174]:51674 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbgCTRlP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Mar 2020 13:41:15 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 09AE760EC2;
        Fri, 20 Mar 2020 17:41:13 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 0/10] NS 8250 UART Device Tree improvements
Date:   Fri, 20 Mar 2020 18:40:57 +0100
Message-Id: <20200320174107.29406-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

this series aims to make it possible to validate NS 8250 compatible serial port 
nodes in Device Tree. It ultimately ends up converting the 8250.txt binding
specification to YAML for json-schema.

It starts by fixing up a couple of issues that would fail validation of
device trees for various boards. Note there might be validation issues in other
boards -- I don't have computing power to run "make dtbs_check" with
CONFIG_OF_ALL_DTBS=y at the moment. I'm happy to fix up issues if somebody
runs the test output to me.

Unless someone has a different idea, I'd like to submit this to arm-soc once
I get the Acks from PXA and Tango maintainers as well as DT reviewers:

  [PATCH 01/10] ARM: dts: pxa*: Don't redeclare phandle references
  [PATCH 02/10] ARM: dts: pxa*: Fix serial port names
  [PATCH 03/10] ARM: dts: pxa*: Make the serial ports compatible with
  [PATCH 04/10] ARM: dts: mmp2-brownstone: Don't redeclare phandle
  [PATCH 05/10] ARM: dts: mmp*: Fix serial port names
  [PATCH 06/10] ARM: dts: mmp*: Make the serial ports compatible with
  [PATCH 07/10] ARM: dts: tango4: Make /serial compatible with ns16550a

What follows is a large yet straightforward fixup of similar nature for PowerPC.
I'd be thankful if PowerPC maintainers could pick this patch up.

  [PATCH 08/10] powerpc/fsl: Make serial ports compatible with ns16550a

Then follows folding of mrvl-serial.txt into 8250.txt (the Marvell serial
port is in fact an XScale UART, a variation of 8250) and the actual
conversion. Perhaps the best route these patches could take via the tty
tree.

  [PATCH 09/10] dt-bindings: serial: Move Marvell compatible string to
  [PATCH 10/10] dt-bindings: serial: Convert 8250 to json-schema

Thanks,
Lubo


