Return-Path: <SRS0=YMt1=X2=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDFFC388F3
	for <linux-serial@archiver.kernel.org>; Tue,  1 Oct 2019 09:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48740215EA
	for <linux-serial@archiver.kernel.org>; Tue,  1 Oct 2019 09:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbfJAJfn (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Oct 2019 05:35:43 -0400
Received: from mga03.intel.com ([134.134.136.65]:48341 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727379AbfJAJfn (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Oct 2019 05:35:43 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 02:35:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,570,1559545200"; 
   d="asc'?scan'208";a="194479720"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by orsmga003.jf.intel.com with ESMTP; 01 Oct 2019 02:35:41 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_lpss: Switch over to MSI interrupts
In-Reply-To: <20191001085940.GE32742@smile.fi.intel.com>
References: <20191001081617.766084-1-felipe.balbi@linux.intel.com> <20191001085940.GE32742@smile.fi.intel.com>
Date:   Tue, 01 Oct 2019 12:35:36 +0300
Message-ID: <877e5ox0yf.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Tue, Oct 01, 2019 at 11:16:17AM +0300, Felipe Balbi wrote:
>> Some devices support MSI interrupts. Let's at least try to use them in
>> platforms that provide MSI capability.
>
> Thanks for the patch!
>
> I think you may clean up qrk_serial_setup() as well.

That would break qrk_serial_setup_dma(), though.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl2THegACgkQzL64meEa
mQb2YRAApWml3T+3sOgsPbV2L5/rPdpKHa0NTib6aybD9fMgCKPaUAXFXEUO8nod
pkdHIuq0kBJAFrQU1rxgqsR041DKck/DLvCBDKHSl0sDLo7jUf6jdM8XHDJVR4i9
oTGpDhJxLofXMUTltgrLVAnBDKy0c7PLa/UNWuHpAUyBYG8PPJ3reAyEch2Cfyye
zTEcfBnw+thjXSsJaBs+x1QSeB3RrP45A7RJuFcjQJRbepc9ly/GTXFcuFqca3Mz
TF6JI/uSEOzQniJqJOoEixVchzlESduFvX+hTx5hDMpPggMCOGVw6RuAdrrjrQGR
mmwl0IGokLbcZJNGX3bpeQayJyuDSHON9x60s7emzQ58+BTPoCghN3w0lLTCdJJg
94q7en/Nd+e98U/biNUH6fk2b/slK0Xxo0TNghLh6qwTXe1eYJEKynynrNdgGO6y
p/QOUhdE1E21OooUEMTh0e7Nt0PN4DqFjEaONd1HSBSnWYLIlnLWXgRtLWEbnWUE
zytXPFZmDfFSbDlBHgeXY9BdiwzOnC31CwdG7hk7pvDbpWYd3gXOJlZJM6jG8HnE
iyP7kQby+4qp1g14UDwB7+RMZx0iWUIcL1XECPhWTBFCGtATEqSrPFQWv+yggte7
hkayXwsys17pPrxSnwW6X0hnjCV3WUC4TKHTJJEdYtEpVfY/56I=
=dcx3
-----END PGP SIGNATURE-----
--=-=-=--
