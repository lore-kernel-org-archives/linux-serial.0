Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A4AC43217
	for <linux-serial@archiver.kernel.org>; Mon, 15 Nov 2021 13:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7982C60F9C
	for <linux-serial@archiver.kernel.org>; Mon, 15 Nov 2021 13:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbhKONrM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Nov 2021 08:47:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:51312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231966AbhKONlr (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Nov 2021 08:41:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B15A263227;
        Mon, 15 Nov 2021 13:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636983531;
        bh=skkhv0lYyNH18qaSh9NQ7j8DdsRuX6Fi5uGKf/w2lSI=;
        h=From:To:Cc:Subject:Date:From;
        b=Ha3jTB+IcSBe+Pmrs4VsDM7uxNRDQYwckLbDF4FqQVPUD4KNLSAV1yF9khomIFFs1
         fmLYOIwdcVyS8CzQdfwLdJxDnlmqu7QjlNRiTIDqFeG3fuQCFOAJVDWbttbsvZcd8O
         jRKNjPxLTVOzrbOUrMWPWbw1sOPh0uo2USBy/vt7lgMm8KO48Xf2nDZd9U2Xp1/0zS
         Qovb8UU43vUHPrfw2sB3UcwfT8dPeGFpLGwNQXdew24yxNmj9b8En/AOD0mKonraZO
         quntIbk8jC7EJeueUyVaOVX9iBgZI60aOynD+VJEGkGnLu0ZlID2VsiizzE0nMf2f1
         h7r96s/pZQuKg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mmcBx-0002zZ-Oj; Mon, 15 Nov 2021 14:38:38 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ilia Sergachev <silia@ethz.ch>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/3] serial: liteuart: fix compile testing and driver unbind
Date:   Mon, 15 Nov 2021 14:37:42 +0100
Message-Id: <20211115133745.11445-1-johan@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Ilia Sergachev noted that the liteuart remove() function would trigger a
NULL-pointer dereference if it was ever called since the driver data
pointer was never initialised.

Turns out there are more bugs in this part of the driver which clearly
has never been tested.

Also fix up the Kconfig dependencies so that the driver can actually be
compile tested.

Note that this series depends on the fix by Ilia:

	https://lore.kernel.org/r/20211115031808.7ab632ef@dtkw

Johan


Johan Hovold (3):
  serial: liteuart: fix compile testing
  serial: liteuart: fix use-after-free and memleak on unbind
  serial: liteuart: fix minor-number leak on probe errors

 drivers/tty/serial/Kconfig    |  4 ++--
 drivers/tty/serial/liteuart.c | 18 +++++++++++++++---
 2 files changed, 17 insertions(+), 5 deletions(-)

-- 
2.32.0

