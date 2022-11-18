Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38B6C4332F
	for <linux-serial@archiver.kernel.org>; Fri, 18 Nov 2022 11:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbiKRL56 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Nov 2022 06:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbiKRL54 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Nov 2022 06:57:56 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9322978185;
        Fri, 18 Nov 2022 03:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1668772674; x=1700308674;
  h=message-id:subject:from:to:cc:date:
   content-transfer-encoding:mime-version;
  bh=QIh1dsN6FNGfG4QOukreO86wpMqHHOp+PVH82+/U2Pc=;
  b=cCZuycHkCdTAdepToZjznIArcdEmqFpGpjzsClzN9QpEW5wrPvCrR6P4
   luso5iqvlTFCLbbaESljnRpeuFEn630Mg5BFMheMd+kFIoO/rzeFQgILQ
   V+SZxgCH1e0thkAtKZoMdfiki8ECtv0ydFYm0PwSbK6oaNibXO+O9ozPE
   wnJ775Ah+nGgDt+aY3DYL6xfw4tgxGdMxWvF33+U7TNSFymYe9Tq908xX
   E1kTcEbvQcgtoXsoaXrA9Kmkf8HcrdECBE7QQ0zzeQPhoUhHxVrMTOsvy
   MokndAWVA2c+ilpwg/3N+ztFazJ4rH3H8qcM5n8pPjaYoGb9JvdRrKM3W
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,174,1665439200"; 
   d="scan'208";a="27447524"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 18 Nov 2022 12:57:52 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 18 Nov 2022 12:57:52 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 18 Nov 2022 12:57:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1668772672; x=1700308672;
  h=message-id:subject:from:to:cc:date:
   content-transfer-encoding:mime-version;
  bh=QIh1dsN6FNGfG4QOukreO86wpMqHHOp+PVH82+/U2Pc=;
  b=ntatMiEjZT3uLgqt6l1KSDyPPYrwrvbGuoZMK4twvWjhEjuC/nRsumVY
   h7HpF+uC6LmgUVYNmuvb3vgPaYUsr+lzWvvLZCazX+Ob6aUmqaa3IAKWj
   7c5yixB1yd8P8fWy/2btj7a+NExika6kApeu9ieSFAIhfxPh5D5HH9IGv
   g51tTPGZeZ9Tq6wCMxeqkvb/3+O5x0eRKwF0fBATdsX1ioXBAt0xFtcsn
   JW6+0wGI4GxDHQCx8vcWFH4kL4ryCU8yQ19eu1O0FaJHcnqlP/DQ6lcrS
   FtBR8sXVg4JqbunOuhcZ6+OOJH1I56nBv/kgvYjLzy464mrmneopILKOj
   A==;
X-IronPort-AV: E=Sophos;i="5.96,174,1665439200"; 
   d="scan'208";a="27447523"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 18 Nov 2022 12:57:52 +0100
Received: from [192.168.2.129] (SCHIFFERM-M2.tq-net.de [10.121.49.14])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 31339280056;
        Fri, 18 Nov 2022 12:57:52 +0100 (CET)
Message-ID: <f7cf39a9c152031a09608a68115e32988617f626.camel@ew.tq-group.com>
Subject: 8250_omap: incorrect RS485 RTS on close during transmission
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 18 Nov 2022 12:57:49 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Lukas,

I've discovered a new issue with EM485 in 8250_omap (and probably other
serial drivers as well?): When closing the TTY device while there is
still an ongoing transmission, the RTS pin will get stuck active until
the TTY is opened again. This can be easily reproduced by running `cat
/dev/zero > /dev/ttySx` and then stopping it using Ctrl-C.

The issue exists in current mainline (6.1-rc5+), and applying "serial:
8250: 8250_omap: Avoid RS485 RTS glitch on ->set_termios()" from next
doesn't solve it. I think it should work with "serial: 8250: 8250_omap:
Support native RS485", but we also need RS485 on AM57xx CPUs, which
don't have native RS485.

I intend to look into this myself next week, but as you've worked on
this code a lot lately, maybe you already have an idea how to fix it?

Regards,
Matthias

