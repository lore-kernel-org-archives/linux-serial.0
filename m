Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E125C7EE23
	for <linux-serial@archiver.kernel.org>; Mon,  5 Jun 2023 11:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjFELHe (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 5 Jun 2023 07:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbjFELHH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 5 Jun 2023 07:07:07 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBFAF2;
        Mon,  5 Jun 2023 04:07:05 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4QZW5d3PDRz9sqS;
        Mon,  5 Jun 2023 13:07:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bernhard-seibold.de;
        s=MBO0001; t=1685963221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4NhRp6jSBZQ969j5kjYsk8SS843t3Di+hIRRW8f6l7s=;
        b=UsuH8TO4MHsNuuHk9EmQasJn18nwBBR/ltKszVmThy05i/wibJEH/wxZoN3DhR870/GEuD
        vuF06rMGWOxdf5oKfwREuGKzOh4yUZSYW7dotVw+yDYbCD+Itwnef335IyAXLupbbSjzR+
        CBz7w2h4PVtNJLrkxjBG4f+x0rFJIvIEtKSOrT6oRM5dXK1acu52zS2afycWMoEEU3ET8T
        nLhrJnjF/zcVbPJK4ZLxGVzfBkeT1HSH3oBTNKk+ilgz+PnotqVZGGp2ApSEMhHa6cnbHv
        gj1eebcaJ8q7kFjS/jYA7PyqQFSe03073lqagipACe3wewri70jr9wUIuptHjQ==
Date:   Mon, 5 Jun 2023 13:06:58 +0200 (CEST)
From:   Bernhard Seibold <mail@bernhard-seibold.de>
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Message-ID: <1098664707.795908.1685963218794@office.mailbox.org>
In-Reply-To: <de21c62d-c8a-ccbd-abbe-45bd1c12847@linux.intel.com>
References: <20230602133029.546-1-mail@bernhard-seibold.de>
 <de21c62d-c8a-ccbd-abbe-45bd1c12847@linux.intel.com>
Subject: Re: [PATCH] serial: lantiq: add missing interrupt ack
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Normal
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


> Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> hat am 02.06.2023 16:5=
6 CEST geschrieben:
>=20
> =20
> On Fri, 2 Jun 2023, Bernhard Seibold wrote:
>=20
> > Currently, the error interrupt is never acknowledged, so once active it
> > will stay active indefinitely, causing the handler to be called in an
> > infinite loop.
>=20
> This has been there since the beginning, it is a bit odd if nobody has hi=
t=20
> this before now.

Let's just say this might be related to the fact that no end-user product t=
hat contains this
peripheral uses the upstream kernel. However this patch does fix a real iss=
ue that was
observed on real hardware.
