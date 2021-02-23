Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785ADC433DB
	for <linux-serial@archiver.kernel.org>; Tue, 23 Feb 2021 10:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2076A64E57
	for <linux-serial@archiver.kernel.org>; Tue, 23 Feb 2021 10:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhBWKTB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Feb 2021 05:19:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:56748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230142AbhBWKS7 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Feb 2021 05:18:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BFB0364E32;
        Tue, 23 Feb 2021 10:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614075497;
        bh=zoKSujW5xF2W1Rcl3DuHrQSJCYJ4HvbfspN5qcIww0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GukVklfbEwGnOG+WY5xlzOSXXVHPSdlRb3uuCCmrkRRdJyQSWax7PLzmcHh/ydD+7
         lFSd0Sd3QUT6fT4WonoSHJF6Iuy5WoU4z+VHKP7GlaeDRqCNpruFn+URCOybu2aFLw
         FlpdhFKo8pZxmfcgcDmYf7nA/AFuT1pAeZiVUiAvXiYDCLBASym+GReTouZhduWQlt
         eftqLf+PJYtMdyXjPUEFUJcg834EM8W7Mu0a0fJp2l/YMck2d27aFhQLpWwF9lqGgJ
         GaoYbkt2SMphJTaUAbTqa2OMbndEJVP+WPeRvX5AuSfEhylKDg0ydWqRgApq5vGxdZ
         66z6QOJUsqnJw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lEUm1-0005n1-KC; Tue, 23 Feb 2021 11:18:33 +0100
Date:   Tue, 23 Feb 2021 11:18:33 +0100
From:   Johan Hovold <johan@kernel.org>
To:     =?utf-8?B?WWVoLkNoYXJsZXMgW+iRieamrumRq10=?= 
        <charles-yeh@prolific.com.tw>
Cc:     "Michael G. Katzmann" <michaelk@IEEE.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Charles Yeh <charlesyeh522@gmail.com>,
        Joe Abbott <jabbott@rollanet.org>
Subject: Re: non-standard baud rates with Prolific 2303 USB-serial
Message-ID: <YDTWeQhmV1/9Lavd@hovoldconsulting.com>
References: <dc3458f1-830b-284b-3464-20124dc3900a@IEEE.org>
 <YDNwxtDxd7JntAXt@hovoldconsulting.com>
 <e2dcc839-3b43-2c80-6ad1-2d97e639b46a@IEEE.org>
 <YDOvLseYXaUHs0lS@hovoldconsulting.com>
 <fb1489c2-b972-619b-b7ce-4ae8e1d2cc0f@IEEE.org>
 <YDPO/JprcDTaPmR4@hovoldconsulting.com>
 <0f9caf26-af58-13a9-9947-47bb646f505e@IEEE.org>
 <YDPS3AP63/PwmwJU@hovoldconsulting.com>
 <cd92ea17-4e0a-2b6c-1032-9a81727841c9@IEEE.org>
 <43da22ced8e14442bbc8babea77e4ed7@MailHC2.prolific.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <43da22ced8e14442bbc8babea77e4ed7@MailHC2.prolific.com.tw>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Charles,

On Tue, Feb 23, 2021 at 10:14:33AM +0000, Yeh.Charles [=E8=91=89=E6=A6=AE=
=E9=91=AB] wrote:

> =E4=BF=9D=E5=AF=86=E8=AD=A6=E8=AA=9E: =E6=9C=AC=E9=9B=BB=E5=AD=90=E9=83=
=B5=E4=BB=B6=E5=85=A7=E5=AE=B9=E5=8F=8A=E5=85=B6=E9=99=84=E5=8A=A0=E6=AA=94=
=E6=A1=88=E5=9D=87=E8=A6=96=E7=82=BA=E6=A9=9F=E5=AF=86=E8=B3=87=E6=96=99=EF=
=BC=8C=E5=8F=97=E4=BF=9D=E5=AF=86=E5=90=88=E7=B4=84=E4=BF=9D=E8=AD=B7=E6=88=
=96=E4=BE=9D=E6=B3=95=E4=B8=8D=E5=BE=97=E6=B4=A9=E6=BC=8F=E3=80=82=E5=85=B6=
=E5=85=A7=E5=AE=B9=E5=83=85=E4=BE=9B=E6=8C=87=E5=AE=9A=E6=94=B6=E4=BB=B6=E4=
=BA=BA=E6=8C=89=E9=99=90=E5=AE=9A=E7=AF=84=E5=9C=8D=E6=88=96=E7=89=B9=E6=AE=
=8A=E7=9B=AE=E7=9A=84=E5=90=88=E6=B3=95=E4=BD=BF=E7=94=A8=EF=BC=8C=E6=9C=AA=
=E7=B6=93=E6=8E=88=E6=AC=8A=E8=80=85=E6=94=B6=E5=88=B0=E6=AD=A4=E4=BF=A1=E6=
=81=AF=E5=9D=87=E7=84=A1=E6=AC=8A=E9=96=B1=E8=AE=80=E3=80=81=E4=BD=BF=E7=94=
=A8=E3=80=81=E8=A4=87=E8=A3=BD=E3=80=81=E6=B4=A9=E6=BC=8F=E6=88=96=E6=95=A3=
=E4=BD=88=E3=80=82=E8=8B=A5=E6=82=A8=E4=B8=A6=E9=9D=9E=E6=9C=AC=E9=83=B5=E4=
=BB=B6=E4=B9=8B=E6=8C=87=E5=AE=9A=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=8C=E8=AB=
=8B=E5=8D=B3=E5=88=BB=E5=9B=9E=E8=A6=86=E9=83=B5=E4=BB=B6=E4=B8=A6=E6=B0=B8=
=E4=B9=85=E5=88=AA=E9=99=A4=E6=AD=A4=E9=83=B5=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=
=99=84=E4=BB=B6=E5=92=8C=E9=8A=B7=E6=AF=80=E6=89=80=E6=9C=89=E8=A4=87=E5=8D=
=B0=E6=96=87=E4=BB=B6=E3=80=82=E9=9B=BB=E5=AD=90=E9=83=B5=E4=BB=B6=E7=9A=84=
=E5=82=B3=E8=BC=B8=E5=8F=AF=E8=83=BD=E9=81=AD=E6=94=94=E6=88=AA=E3=80=81=E6=
=90=8D=E6=AF=80=E3=80=81=E9=81=BA=E5=A4=B1=E3=80=81=E7=A0=B4=E5=A3=9E=E3=80=
=81=E9=81=B2=E5=88=B0=E6=88=96=E4=B8=8D=E5=AE=8C=E6=95=B4=E3=80=81=E6=88=96=
=E5=8C=85=E5=90=AB=E7=97=85=E6=AF=92=EF=BC=8C=E7=84=A1=E6=B3=95=E4=BF=9D=E8=
=AD=89=E5=85=B6=E5=AE=89=E5=85=A8=E6=88=96=E7=84=A1=E8=AA=A4=E3=80=82=E5=AF=
=84=E4=BB=B6=E4=BA=BA=E4=B8=8D=E6=89=BF=E6=93=94=E5=9B=A0=E6=9C=AC=E9=9B=BB=
=E5=AD=90=E9=83=B5=E4=BB=B6=E7=9A=84=E9=8C=AF=E8=AA=A4=E6=88=96=E9=81=BA=E6=
=BC=8F=E6=89=80=E7=94=A2=E7=94=9F=E7=9A=84=E4=BB=BB=E4=BD=95=E6=90=8D=E5=AE=
=B3=E8=B3=A0=E5=84=9F=E8=B2=AC=E4=BB=BB=E3=80=82 Confidentiality Notice: Th=
is e-mail message together with any attachments thereto (if any) is confide=
ntial, protected under an enforceable non-disclosure agreement, intended on=
ly for the use of the named recipient(s) above and may contain information =
that is privileged, belonging to professional work products or exempt from =
disclosure under applicable laws. Any unauthorized review, use, copying, di=
sclosure, or distribution of any information contained in or attached to th=
is transmission is strictly prohibited and may be against the laws. If you =
have received this message in error, or are not the intended recipient(s), =
please immediately notify the sender by e-mail and delete this e-mail messa=
ge, all copies, and any attached documentation from your computer. E-mail t=
ransmission cannot be guaranteed to be secure or error-free as information =
could be intercepted, corrupted, lost, destroyed, arrive late or incomplete=
, or contain viruses. The sender therefore does not accept liability for an=
y damage caused by any errors or omissions in the contents of this email.

Can you please resend from your other account so that this footer isn't
included in your replies to the list?

Johan
