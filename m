Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37559C433EF
	for <linux-serial@archiver.kernel.org>; Sun, 16 Jan 2022 23:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbiAPXPr (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 16 Jan 2022 18:15:47 -0500
Received: from mailgw.felk.cvut.cz ([147.32.82.15]:52056 "EHLO
        mailgw.felk.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbiAPXPq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 16 Jan 2022 18:15:46 -0500
X-Greylist: delayed 552 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Jan 2022 18:15:46 EST
Received: from mailgw.felk.cvut.cz (localhost.localdomain [127.0.0.1])
        by mailgw.felk.cvut.cz (Proxmox) with ESMTP id 33D7730B035E;
        Mon, 17 Jan 2022 00:06:33 +0100 (CET)
Received: from cmp.felk.cvut.cz (haar.felk.cvut.cz [147.32.84.19])
        by mailgw.felk.cvut.cz (Proxmox) with ESMTPS id 4EBBA30ADE45;
        Mon, 17 Jan 2022 00:06:32 +0100 (CET)
Received: from haar.felk.cvut.cz (localhost [127.0.0.1])
        by cmp.felk.cvut.cz (8.14.0/8.12.3/SuSE Linux 0.6) with ESMTP id 20GN6WVe016696;
        Mon, 17 Jan 2022 00:06:32 +0100
Received: (from pisa@localhost)
        by haar.felk.cvut.cz (8.14.0/8.13.7/Submit) id 20GN6VOV016695;
        Mon, 17 Jan 2022 00:06:31 +0100
X-Authentication-Warning: haar.felk.cvut.cz: pisa set sender to pisa@cmp.felk.cvut.cz using -f
From:   Pavel Pisa <pisa@cmp.felk.cvut.cz>
To:     Wander Lairson Costa <wander@redhat.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Subject: TTY layer discussion about generic FIFO depth and Rx iddle timeout control
Date:   Mon, 17 Jan 2022 00:06:31 +0100
User-Agent: KMail/1.9.10
Cc:     Rostislav =?iso-8859-1?q?Lisov=FD?= <lisovy@gmail.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Jiri Slaby <jslaby@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <202201170006.31440.pisa@cmp.felk.cvut.cz>
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Dear Wander and Greg,

[resend on base of email-bot of Greg Kroah-Hartman's inbox]

I have noticed that you have sent enhancements
to the TTY layer.

I have worked on architecture of automotive LIN-bus
support for Linux UARTs. The SocketCAN API was idea
of Oliver Hartkopp and we have designed internals
to implement actual protocol. Rostislav Lisovy
was main author at our university in 2011. The code
has been used and is used by more people and I have
helped its integration to local Volkswagen subsidiary
projects. I have helped to maintain it for years
even that I have actually no use for it or contract.
But is seems usable...

I am not sure if it can reach quality standards
for mainline but I have tried to consolidate
many forks and copies from our original GIT
server which can be found on GitHub and united
project under

  https://github.com/lin-bus

Kernel part - slLIN TTY discipline - can be found there

  https://github.com/lin-bus/linux-lin/tree/master/sllin

Documentation

  https://github.com/lin-bus/linux-lin/wiki/

The main obstacle to have version which can be used
with different UARTs seamlessly is missing internal low
level kernel API which would allow to control Rx trig
level.

I have not checked your changes yet but I would be happy
if some API is available for this control. Please see
issue 

  https://github.com/lin-bus/linux-lin/issues/13

Please suggest where to discuss the proposal/solutions
or if you plan to implement something like that.

I would be happy to work on that myself or with my students
but I personally do not get to that probably earlier
than in summer. I have to finish project for European Space
Agency at PiKRON company. We have quite lot of work
to switch our Computer Architectures classes and corresponding
QtMips/QtRvSim simulator to RISC-V etc...
Mainlining CTU CAN FD driver has higher priority than LIN for
me as well.

So my actual motivation is to document the need and get some
feedback if some such solution is on the horizon
and what should API look like if I get to it ourselves etc..

Best wishes,

                Pavel
--
                Pavel Pisa
    phone:      +420 603531357
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://dce.fel.cvut.cz/
    personal:   http://cmp.felk.cvut.cz/~pisa
    projects:   https://www.openhub.net/accounts/ppisa
    CAN related:http://canbus.pages.fel.cvut.cz/
    Open Technologies Research Education and Exchange Services
    https://gitlab.fel.cvut.cz/otrees/org/-/wikis/home


