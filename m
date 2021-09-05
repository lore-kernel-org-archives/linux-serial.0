Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73444C433EF
	for <linux-serial@archiver.kernel.org>; Sun,  5 Sep 2021 15:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59CAE60F6D
	for <linux-serial@archiver.kernel.org>; Sun,  5 Sep 2021 15:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237589AbhIEP7V (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 5 Sep 2021 11:59:21 -0400
Received: from mout.gmx.net ([212.227.17.20]:32981 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236513AbhIEP7T (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 5 Sep 2021 11:59:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630857474;
        bh=yzs5x4RVeCX7GCJ8zRpi43BntS7NvKdUcjfhqS7PxBo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=gU/cBiqIs9og4QKJpPoF3Ct1B8N3499FJj7/lQmpuOMvTTHGI4zuaxRZffvB+qQ+F
         rPzNj4H66HqLwUuBaYHfzXUfISSCFAg2mbg4K5yrTicYFZQbcy1iUk8PTZoW6cBKS3
         yFHTt5ZUFm7OB+3+fC/KCPhORW30tz7D6McN1+Po=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1M72oB-1mKRxd0Qe7-008e5s; Sun, 05 Sep 2021 17:57:54 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Len Baker <len.baker@gmx.com>, Kees Cook <keescook@chromium.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Randy Wright <rwright@hpe.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Tobias Diedrich <tobiasdiedrich@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>, linux-serial@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] serial: 8250_pci: Prefer struct_size over open coded arithmetic
Date:   Sun,  5 Sep 2021 17:57:28 +0200
Message-Id: <20210905155728.11147-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UYDJTK6j41RrEupZsDTFqHaTUhbI8HGQxCwMtcnqfE2U85RRCSV
 uLX/EhqSg4m87zkU70rCJK16vpW5d3btW27vcx2csvU3s68rglN3QnJ3ubm8aZ98J4XMjBu
 P28AOvhifvNtgQLJG5/3hXDUjlJ8MHHvzk/NbHf1iruZ9PYHSgP5ygZGdev2JM4M5XA4l1R
 q8a7jQhoN6wEESNNZk/Kw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CS+yAjvovFc=:rgAzYenUXZjYF4iryq9bCF
 evzwuhqv04eSSJ/e67BzboIPjwtNvKKRJNks7j746SI2vxWkfMZiX0qGVIADB49Mnht/vyPRm
 E6xUE60CO1s0lLx4IkD7N0d5dXCHEJqNdcEObNXJngb94H2StF3zUbx1gsQ93Izq+SF9gJ7W9
 KOJvVLv+l/ubmlpom5os3kj+1ncBpNqTmaCNeko9H04/uhaDVOTVomv1KOSSJhsPTiL7EYGT9
 4e3z/JOs0DyL8qtVpqr0WDMleNWelc6Xh6Kttpa3qNmC47DNBtPb1LNdwuKR/YaxukkDhuGWz
 UpjFRXVyKkQzysfeGSbzLzJa/PBGLhLh4Pu5GF6kXhcmfK9Z31kyhU5jJLz1zneBM06ehqdhr
 PsphygPzWvtqfqu3k+HeAnIw9Misr22f4WAtqrL1OeGpmXc/5pzHy16Aq6bNVHnt2+38/l7n0
 /X9eTGNMf9c1dyJjf0vw8g6stemRh3wZdC8l+RL0qcUD/YZWuRqWjkOuBKCtMZ16WqOcyJUcR
 4wEqsIcwf9WS1ldYF6Al+eMukTPymGI77e/YgbZ/Hoaznj90xq18Ri8r3ce7ri+cxVEpdqNKn
 4fjoHfT4P0wSy9fHmRxQBFSkcJMGh8U6wneTOaM7JgJENoalyiLgur8pE687lZs6GGLdA3rP/
 oc5zXldk9M11H8PQAlTVPLr58jAbAL7idT+I7D/tqyqeacUs17iAKMzNC2/RJdsFThPFXgIQo
 ZHMOqzoXazNdVkK7D6KY6DuSeNwymzmv4oKNwW2/MwR0GSD0TCfpB29xf4jNuyMWH9K2PMtO/
 1Spf+n0vufsaUhJhA90oFortHfl/ZJaoKBDHysSQO3aXXFVaYvYXuT4r6EdfAT/5c6z+zVaHY
 fBzeIqM1hTHhEzMatwaJdWvlwQEs3l+5gSqSJIiHCv0+wLRQJ1+4If7hkJF0g7Mb9GysrC4lv
 QyY6xX7r4dG+eG1iW/ENqRacXcT/3RZdrDZyiF9ZzE5Cd3r1ha1x1Oj826TtaFEbN9uI6rSN6
 Nzd39L5oIxZmomv4pN/DcOcbD8n4mvQOQz9gZci5TyP/nNgFXnSjdQ7KZ1HYl3cg2egiLEmYE
 27W9gh4RXVgZ4z4v04UMzq7mSwdLX/dj8bFNo4U1OFSQiWHOYCDrqI1rQ==
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

As noted in the "Deprecated Interfaces, Language Features, Attributes,
and Conventions" documentation [1], size calculations (especially
multiplication) should not be performed in memory allocator (or similar)
function arguments due to the risk of them overflowing. This could lead
to values wrapping around and a smaller allocation being made than the
caller was expecting. Using those allocations could lead to linear
overflows of heap memory and other misbehaviors.

So, use the struct_size() helper to do the arithmetic instead of the
argument "size + size * count" in the kzalloc() function.

[1] https://www.kernel.org/doc/html/v5.14/process/deprecated.html#open-cod=
ed-arithmetic-in-allocator-arguments

Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
 drivers/tty/serial/8250/8250_pci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/=
8250_pci.c
index a808c283883e..b97ade35d4a3 100644
=2D-- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -3981,9 +3981,7 @@ pciserial_init_ports(struct pci_dev *dev, const stru=
ct pciserial_board *board)
 			nr_ports =3D rc;
 	}

-	priv =3D kzalloc(sizeof(struct serial_private) +
-		       sizeof(unsigned int) * nr_ports,
-		       GFP_KERNEL);
+	priv =3D kzalloc(struct_size(priv, line, nr_ports), GFP_KERNEL);
 	if (!priv) {
 		priv =3D ERR_PTR(-ENOMEM);
 		goto err_deinit;
=2D-
2.25.1

