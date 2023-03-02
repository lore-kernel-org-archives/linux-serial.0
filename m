Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74F4C6FA8E
	for <linux-serial@archiver.kernel.org>; Thu,  2 Mar 2023 12:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCBMUd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 2 Mar 2023 07:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjCBMUb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 Mar 2023 07:20:31 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9FD3B870
        for <linux-serial@vger.kernel.org>; Thu,  2 Mar 2023 04:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1677759630; x=1709295630;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jc7NCjQNaCgCuZVespPULBgPudxFGzjmmOwhTE6K09E=;
  b=EavFIFKJQ206MlUDTkojKAwT2nZC82qyUa6DkNTZunYPV9odZ41fYh3j
   F96TfjNJ/mqAt0OoEJNq24BbezjTBAbhtkbSkieSI+/Wuz2CIPwbkv/tc
   UJzmjpqCj561o+IHVYH3LkJoY/nnlh327k+zhKLyo7YSC6JdXAx7K/oEl
   SmZ0trs6J6rHSfGwQGsrUEDnSObQqKggqUa15BH1fid2vZIl2byT8YVEx
   933wfuzN4mbXn0LBH7X8sVJO9N5iMRZuUppqpsR94+Iluz2Px4P2Pmd8k
   16oBlKSas8YCk0fgoQZa4WiWKSWfAEdk4YcHm6XQxUbgi1U1D/Zaw8N2I
   A==;
X-IronPort-AV: E=Sophos;i="5.98,227,1673910000"; 
   d="scan'208";a="29424524"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 02 Mar 2023 13:20:28 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 02 Mar 2023 13:20:28 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 02 Mar 2023 13:20:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1677759628; x=1709295628;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jc7NCjQNaCgCuZVespPULBgPudxFGzjmmOwhTE6K09E=;
  b=hr6dIdZaqnG+kXV825HVvmihOgbDw9v8v7MnX8UEshFR4wXWVNdoyvS9
   2U+ZDqeyD5Zx+Fy+Qixi+044k3a3l5PGnYTq36absE2FflZ5b/C16MUT3
   g6zUnDhgI4ed3rDzmqtPyhCC8bc30j7401g8WnxeOWyJek0JF4tCPCtTY
   P9CLuIOsz5xY+TgmsHbiozvolRcVHz/1mtuhLs55i5smVP2dPSYg/Cc00
   ffvrbLZaNm+p0mwYPkz00lEa2c5PXev+KrGGXJMYnB4WjJC7DW8e1w1+e
   PJ6atOgNxl/hR8BeO3IFmHUIO5wY/EJGQGK2ilfcIwTQ9iNrR7Sunf7Li
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,227,1673910000"; 
   d="scan'208";a="29424523"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 02 Mar 2023 13:20:27 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id AFFCF280056;
        Thu,  2 Mar 2023 13:20:27 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] serial: imx: Simplify imx_uart_type
Date:   Thu, 02 Mar 2023 13:20:25 +0100
Message-ID: <5912297.lOV4Wx5bFT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20230302115547.sacjk4ekwmfev2xz@pengutronix.de>
References: <20230302114810.1859500-1-u.kleine-koenig@pengutronix.de> <20230302115547.sacjk4ekwmfev2xz@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Uwe,

Am Donnerstag, 2. M=E4rz 2023, 12:55:47 CET schrieb Uwe Kleine-K=F6nig:
> * PGP Signed by an unknown key
>=20
> Hello,
>=20
> On Thu, Mar 02, 2023 at 12:48:10PM +0100, Uwe Kleine-K=F6nig wrote:
> > There is no point in casting a struct uart_port to a struct imx_port
> > just to access the first member of the latter (a struct uart_port).
> >=20
> > This introduces code changes.
>=20
> Please disregard this patch. While the patch is fine as is, I just
> noticed a few more functions in this driver that can be simplified
> accordingly. I'm about to send out an improved version (with a different
> subject, so not called v2).

Shouldn't this cast on the other locations be converted into a to_imx_port(=
)=20
function using container_of as well?

Best regards,
Alexander

> Best regards
> Uwe


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


