From: Grant Edwards <grante@visi.com>
Subject: Re: Enhancing pty driver to act like a serial port?
Date: Sun, 22 Jun 2008 20:02:22 +0000 (UTC)
Message-ID: <g3mb4e$52v$1@ger.gmane.org>
References: <Pine.LNX.4.64.0806221455410.18596@maggie.lkpg.cendio.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:32867 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754121AbYFVUCj (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 22 Jun 2008 16:02:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KAVlg-0000eN-6O
	for linux-serial@vger.kernel.org; Sun, 22 Jun 2008 20:02:32 +0000
Received: from 67.220.10.73 ([67.220.10.73])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Sun, 22 Jun 2008 20:02:32 +0000
Received: from grante by 67.220.10.73 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Sun, 22 Jun 2008 20:02:32 +0000
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2008-06-22, Peter =C5strand <astrand@cendio.se> wrote:
>
>>The question of emulating a serial port in user-space has come
>>up a number of times in various contexts during the past few
>>years. =20
>>
>>The current pty driver isn't really sufficient when the
>>application actually expects to be connected to a physical
>>serial port:=20
>
> A better userspace solution would be great. I'm maintaining=20
> cyclades-serial-client. It relies on LD_PRELOAD, which is not
> very elegant.=20

I can imagine.   (I used a few Cyclades 8-port boards many
years ago, and always liked Cyclades' product lines).

>>you can't set parity or word length, and the modem
>>control/status ioctl() calls fail.
>
> Oh. I was just investigating why it's not possible to set
> "cs7" on the pty. stty fails with:
>
> $ stty cs7 -F /my/pty
> stty: /my/pty: unable to perform all requested operations
>
> I guess this explains it.=20

Yup.  It wouldn't be difficult at all to make the pty driver
act like a serial device, but there's a huge difference between
something being easy to change and getting those changes
accepted.  Judging by the silence I got in response to my query
the chances of such a change being accepted are pretty much
zero.

--=20
Grant Edwards                   grante             Yow!  The PINK SOCKS=
 were
                                  at               ORIGINALLY from 1952=
!! But
                               visi.com            they went to MARS ar=
ound
                                                   1953!!

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
