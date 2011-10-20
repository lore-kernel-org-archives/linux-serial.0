From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH v2] UART: add CSR SiRFprimaII SoC on-chip uart drivers
Date: Thu, 20 Oct 2011 16:37:32 +0800
Message-ID: <CAGsJ_4wLbqRfxVh=kugLnzBYCRLjok6aKgUW-u-qyEqyMTv6=Q@mail.gmail.com>
References: <1318570799-3785-1-git-send-email-Barry.Song@csr.com>
 <CAGsJ_4w6fGH+G9KapHXzCwMhz_NKfPdCxs7rF5hWKw2LGUpwWA@mail.gmail.com>
 <20111018181319.GA7015@kroah.com> <CAGsJ_4xJzL6dfSmmae8LH6kt2g1PmevgrFWgYLR3Tif8PD0bCQ@mail.gmail.com>
 <CAKnu2MqUW=6tH0A1Zae0MgMyKiU4X26c0jGCQFKeJrxJA2GyzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60987 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753905Ab1JTIhx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 20 Oct 2011 04:37:53 -0400
Received: by bkbzt19 with SMTP id zt19so3243977bkb.19
        for <linux-serial@vger.kernel.org>; Thu, 20 Oct 2011 01:37:52 -0700 (PDT)
In-Reply-To: <CAKnu2MqUW=6tH0A1Zae0MgMyKiU4X26c0jGCQFKeJrxJA2GyzA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.ml.walleij@gmail.com>
Cc: Greg KH <greg@kroah.com>, alan@linux.intel.com, Rong Wang <Rong.Wang@csr.com>, Bin Shi <Bin.Shi@csr.com>, workgroup.linux@csr.com, linux-serial@vger.kernel.org, Barry Song <Baohua.Song@csr.com>, linux-arm-kernel@lists.infradead.org

2011/10/20 Linus Walleij <linus.ml.walleij@gmail.com>:
> 2011/10/19 Barry Song <21cnbao@gmail.com>:
>> 2011/10/19 Greg KH <greg@kroah.com>:
>>> So should it go through the pinmux tree? =C2=A0Or do you want to wa=
it for the
>>> 3.3 kernel release to get this merged?
>>
>> i think we can go ahead through Linux W's pinmux tree. Linus, would
>> you like to take care once Alan ack this.
>
> It's a bit late, and I don't know if Torvalds will pull my pin contro=
l tree
> yet, that's uncertain since it's an all new subsystem. It's stabilizi=
ng
> for the merge window.
>
> I would suggest that you see if my tree gets pulled in the merge
> window, and if and when it does, send the patch as a single patch
> directly to Torvalds with Alan's ACK and explain the situation
> with cross-dependence and all.

thanks. that is ok to me. i suppose Torvalds will pull your tree in
this merge window or next.

if this window, i will send that to Torvalds, if next, i'd like to go
through this tree and get merged in 3.3 together with your pinmux.

>
> Linus Walleij
>
-barry
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
