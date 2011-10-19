From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH v2] UART: add CSR SiRFprimaII SoC on-chip uart drivers
Date: Thu, 20 Oct 2011 00:02:12 +0200
Message-ID: <CAKnu2MqUW=6tH0A1Zae0MgMyKiU4X26c0jGCQFKeJrxJA2GyzA@mail.gmail.com>
References: <1318570799-3785-1-git-send-email-Barry.Song@csr.com>
	<CAGsJ_4w6fGH+G9KapHXzCwMhz_NKfPdCxs7rF5hWKw2LGUpwWA@mail.gmail.com>
	<20111018181319.GA7015@kroah.com>
	<CAGsJ_4xJzL6dfSmmae8LH6kt2g1PmevgrFWgYLR3Tif8PD0bCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44962 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244Ab1JSWCN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 19 Oct 2011 18:02:13 -0400
Received: by gyb13 with SMTP id 13so2125496gyb.19
        for <linux-serial@vger.kernel.org>; Wed, 19 Oct 2011 15:02:13 -0700 (PDT)
In-Reply-To: <CAGsJ_4xJzL6dfSmmae8LH6kt2g1PmevgrFWgYLR3Tif8PD0bCQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: Greg KH <greg@kroah.com>, alan@linux.intel.com, Rong Wang <Rong.Wang@csr.com>, Bin Shi <Bin.Shi@csr.com>, workgroup.linux@csr.com, linux-serial@vger.kernel.org, Barry Song <Baohua.Song@csr.com>, linux-arm-kernel@lists.infradead.org

2011/10/19 Barry Song <21cnbao@gmail.com>:
> 2011/10/19 Greg KH <greg@kroah.com>:
>> So should it go through the pinmux tree? =A0Or do you want to wait f=
or the
>> 3.3 kernel release to get this merged?
>
> i think we can go ahead through Linux W's pinmux tree. Linus, would
> you like to take care once Alan ack this.

It's a bit late, and I don't know if Torvalds will pull my pin control =
tree
yet, that's uncertain since it's an all new subsystem. It's stabilizing
for the merge window.

I would suggest that you see if my tree gets pulled in the merge
window, and if and when it does, send the patch as a single patch
directly to Torvalds with Alan's ACK and explain the situation
with cross-dependence and all.

Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
