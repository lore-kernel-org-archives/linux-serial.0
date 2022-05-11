Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B30FC433F5
	for <linux-serial@archiver.kernel.org>; Wed, 11 May 2022 09:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244014AbiEKJHJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 11 May 2022 05:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239898AbiEKJG7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 May 2022 05:06:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0352CE18
        for <linux-serial@vger.kernel.org>; Wed, 11 May 2022 02:06:54 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1noiJ0-0008QC-2J; Wed, 11 May 2022 11:06:50 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1noiIt-001eVg-CQ; Wed, 11 May 2022 11:06:42 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1noiIr-008zqw-8U; Wed, 11 May 2022 11:06:41 +0200
Date:   Wed, 11 May 2022 11:06:41 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Alan Cox <alan@linux.intel.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-serial@vger.kernel.org, kernel@pengutronix.de
Subject: broken FSL erratum handling for 8250 on MPC8xxx
Message-ID: <20220511090641.gj66ewjpcx2ra4xo@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kb2fl3rg4mvl4cxj"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--kb2fl3rg4mvl4cxj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Paul, hello Alan, hello NXP,

I have an MPC8313 here and the problem that a change introduced in 2011
(i.e. 9deaa53ac7fa ("serial: add irq handler for Freescale 16550
errata.")) results in a bug. (Will send a fix for that in a separate
thread.)

The thing that bothers me is: The machine in question doesn't seem to
have the behaviour described in the chip erratum document[1]. I'm using
a MPC8313CVRAGDC, and even when I send a 10s long break, I only get a
single interrupt and LSR doesn't get the BI bit set after the first
event.
(The erratum applies to MPC8313E, the MPC8313 doesn't have a dedicated
errata document and reference manual. The latter states that it applies
to MPC8313, too, the errata document doesn't. As the difference betweeen
MPC8313 and MPC8313E is only an encryption engine I would expect that
the UART of the MPC8313 shows the same behaviour as the MPC8313E?!)

Do you have some information which CPUs are actually affected, or is
there a problem with my diagnosis that MPC8313CVRAGDC isn't affected?

@Paul: Do you still remember which machine you saw the problem on and
which version of the erratum you had at the time?

Best regards
Uwe

[1] General17 in https://www.nxp.com/docs/en/errata/MPC8313ECE.pdf

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--kb2fl3rg4mvl4cxj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmJ7fJ4ACgkQwfwUeK3K
7AnrJwf8DFPxZzzs62mOR7ro6yqIGZDDVpLyWgrRRetU+JTqRMgZxRq7zoL1LPIg
PlvXzLDJrc8opxoQtAA7pc89RpUCH2fa6nNqaF5BtD10+KeEpi3l8cQsKTH9UQIH
mlOrymnHg2ljWu71GKdjdD/v1cWXUKWIxTAyhp90/cvyg8FWUAK3FfcTrS9uF7ys
B/rVIuiLNzetN1U2nYxT0OTmeIvNlmrSgLkvH6ovL39oKGAazNDJawKh1x9LdIlr
KcRsm/D21uSz4+jlFv4036VwpQK45/3XTix6zL0YTZOHZcRnf3wSCAfmtSBHfxgu
nM0r88ShnTmqnMxU/Ln7c8fID5TSnw==
=Wosd
-----END PGP SIGNATURE-----

--kb2fl3rg4mvl4cxj--
