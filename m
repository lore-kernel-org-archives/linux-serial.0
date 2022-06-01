Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71465CCA478
	for <linux-serial@archiver.kernel.org>; Wed,  1 Jun 2022 15:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348423AbiFAPIF (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Jun 2022 11:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344567AbiFAPIE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Jun 2022 11:08:04 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002556D181
        for <linux-serial@vger.kernel.org>; Wed,  1 Jun 2022 08:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654096067;
        bh=2kv8RiXdA0qxNspb/2fDNaF0Q8s5Jy/Qmx21CY+FbW0=;
        h=X-UI-Sender-Class:Date:To:Cc:References:Subject:Reply-To:From:
         In-Reply-To;
        b=E+MZ4r+TMj+QZdS742fp620K9oAyL28TQ0+A/Lk0xgMI9+Ug604xyFSc1zFcHD8E9
         dUbMEzYioAfOcjADFKCOccJFJbAJUDUha6DtDh8oPg2cVi47c/QO0ggzY6IBz74pGF
         k6ZEYY8g6MgtIr9WTIZ+QLhBNdvAFATyh9idcgCA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.21] ([217.61.157.109]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUGi9-1oM6533Wvj-00RHqb; Wed, 01
 Jun 2022 17:07:46 +0200
Message-ID: <23accb82-8f75-4773-4fad-b6218930da62@public-files.de>
Date:   Wed, 1 Jun 2022 17:07:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
To:     angelogioacchino.delregno@collabora.com
Cc:     gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org,
        matthias.bgg@gmail.com
References: <CAGXv+5Hx7cRwNzLWrExcFGy=MMOc3-0EbqCanv2E0G_DKXLCgg@mail.gmail.com>
Subject: [BUG] mtk serial broken on mt7622 with 5.18.0
Content-Language: en-US
Reply-To: frank-w@public-files.de
From:   Frank Wunderlich <frank-w@public-files.de>
In-Reply-To: <CAGXv+5Hx7cRwNzLWrExcFGy=MMOc3-0EbqCanv2E0G_DKXLCgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6HmAzGI+kinOSC+Tl2WcUAHn+3P/WzdwxHLd5Tmjfz5a41e0Skx
 l+5KgKrzBISREEBeZ3GuEeKyClVMKWEN0Z/qXZUUkGhCWRGoZTlcK8MpJzWd7MlfYF4XjlU
 jkjpBr8WcdxD19q5V1CF1vavRPK/SA0q2MseKN/s+XC1BMZZA7a7Mbh3iSFMuXandWC59iW
 xroIVTM/42n1asMBmH0Zw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Iv6HGkEx/fc=:1DMtqfDyP3hN/Ill9AC4Gy
 rsZIcHGn2NZh4OyRutBiJQ+2tpf23z48mAfoJXRsVZ+otUf971zU9up3JVpU0ztcx6IOcTp8C
 SXrNCPWbW0se6mvAnCQ7PpEVt6JOuNp3tnk1Fr7ImK8FOGqxk1nB1bW7XqSXLCXzNYBsSfEFJ
 NbjNmwZBjURUqjKP3ZBdnFi7CvG+1IPXCisHwvcxF2jwQ0atAFjV9N/M6rN4KWUybehqvIrdf
 i11vhjUbL4Nww7pYu7sKl2FpnCRPdxjVAGw9fDIXo2vGasE1YUGB0vYjhMhOsLVXqow/JM8In
 rLVFC8CosGxmdON5cwQFPBtPV7kSyvZ27UTu7ARIoxyPxVOQAKFiHSL3o2KLIbbbOuhYpWKPZ
 WCYT55Txq8g41MiuHWr6oiE7PClkVJnVOYR02Rj9vPLX7ESmPTgCaJXzTleiARyhEXgLkkVWA
 z9t0lDmD0q7JpnuPeUBMI750/G1gFHZZlJ0ebPk9EniL2YaVgSYu65DfrS73LuTk8z9aaEhrO
 fklsz01W1ubCyAknSIovTUe1VkH/WRLjUmuhHOa/+s+9ikLhOcjlHIBeHjMSDXVqAaAuVjQJ/
 Wh1OYewI6qsMI49AXc779kigr4hRt/x6dzBWLU2Elpbe6KuOG/DxscPMZgSsyR1vFh+FLPWOv
 AYqX63/DcTdfbDVZKbCAmKqXWsybktfGC9sOQd9U4c/pmJJMhv4aCTtf6GFCRAvFYPwa7W3dx
 x7a9qcv7sRuHgpQWfdpkMHbZbOF9CEwlnxTVdUVCC6h7N1l5U3jbsLQjjTmV6kKg2VCkZ8/mf
 J6WD/gEytiuCFTiRS68dPfyumFmrfUVRv3Lsayo/x58ZCqaj5gAJnKYHFk4Y44o2lDT2dFYt/
 GDcmpCnZG2R74kWXVJPsYQviHMQtQTRBBNZxMywo/VupFMsBU08wNRm/uJUu4viy+tH1PHS4+
 uZZSAafgzh638p3aLRlMAJi9cxgUt3PbjclQUI/lrH1qBv5yF+v60L2goVOSkxdD7X4v42ljl
 tQjlsk3A2dqt8mLqbpGMnXNWusl+Tk46RgRr3y+pFHCf9IDxImMuz/Dw/lE17jn6Ndhmko/yk
 +/Dqp7Hpgk1dBboNSl74IC3e12nnfv2qYI8QvngKOB/Ck30N7muI2tHZA==
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

i get a serial console hang on booting my mt7622 bananapi r64 with 5.18.0

[    0.591802] Serial: 8250/16550 driver, 3 ports, IRQ sharing disabled
[    0.599915] printk: console [ttyS0] disabled
[    0.624563] 11002000.serial: ttyS0 at MMIO 0x11002000 (irq =3D 126,
base_baud =3D 1562500) is a 16550A

git bisect points to this commit (cannot revert it alone)

6f81fdded0d024c7d4084d434764f30bca1cd6b1 is the first bad commit
commit 6f81fdded0d024c7d4084d434764f30bca1cd6b1
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.co=
m>
Date:   Wed Apr 27 15:23:27 2022 +0200

     serial: 8250_mtk: Make sure to select the right FEATURE_SEL

     Set the FEATURE_SEL at probe time to make sure that BIT(0) is enabled=
:
     this guarantees that when the port is configured as AP UART, the
     right register layout is interpreted by the UART IP.

     Signed-off-by: AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com>
     Cc: stable <stable@vger.kernel.org>
     Link:
https://lore.kernel.org/r/20220427132328.228297-3-angelogioacchino.delregn=
o@collabora.com
     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

  drivers/tty/serial/8250/8250_mtk.c | 7 +++++++
  1 file changed, 7 insertions(+)

merged by 6811a466d27b "Merge tag 'tty-5.18-rc7'"

reverted these 2 commits works for me
e1bfdbc7daca 2022-04-27 serial: 8250_mtk: Fix register address for
XON/XOFF character
6f81fdded0d0 2022-04-27 serial: 8250_mtk: Make sure to select the right
FEATURE_SEL

have see this discussion [1], but can't manage to import mbox file to
thunderbird yet

regards Frank

[1]
https://lore.kernel.org/linux-arm-kernel/CAGXv+5Hx7cRwNzLWrExcFGy=3DMMOc3-=
0EbqCanv2E0G_DKXLCgg@mail.gmail.com/#t
