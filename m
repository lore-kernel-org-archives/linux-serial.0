From: Stanislav Kozina <skozina@redhat.com>
Subject: Re: n_tty_read panic
Date: Mon, 30 Jul 2012 12:41:57 +0200
Message-ID: <501664F5.5010705@redhat.com>
References: <2cd866$1c50tmu@irja2-156.sinamail.sina.com.cn> <20120725124416.474bed6b@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:13740 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752177Ab2G3KmO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 30 Jul 2012 06:42:14 -0400
In-Reply-To: <20120725124416.474bed6b@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: =?UTF-8?B?5aSn5p6X?= <yourdarling1999@sina.com>, linux-serial <linux-serial@vger.kernel.org>

Seems that tty->read_buf =3D=3D NULL at the very beginning of n_tty_rea=
d():

1723 do_it_again:
1724
1725         BUG_ON(!tty->read_buf);

tty->read_buf access needs tty->read_lock to be held, correct? So=20
perhaps the patch would be:

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index ee1c268..9decb1c 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1728,7 +1728,11 @@ static ssize_t n_tty_read(struct tty_struct *tty=
,=20
struct file *file,

  do_it_again:

+#ifdef CONFIG_BUG
+       spin_lock_irqsave(&tty->read_lock, flags);
         BUG_ON(!tty->read_buf);
+       spin_unlock_irqrestore(&tty->read_lock, flags);
+#endif

         c =3D job_control(tty, file);
         if (c < 0)

Regards,
-Stanislav Kozina

> On Wed, 25 Jul 2012 09:47:09 +0800
> "=E5=A4=A7=E6=9E=97"<yourdarling1999@sina.com>  wrote:
>
>> Hello.
>>
>> Here's a kernel panic caused by n_tty_read, linux kernel version is =
2.6.38.8.
>>
>>
>> There are many discussions on the subject, this bug solved yet? Wher=
e can I download the patch?
> Thats a different trace to the others I've seen. Several races have b=
een
> fixed, there are certainly a couple of others left to sort eventually=
=2E I
> don't believe anyone is currently working on them (and indeed until t=
he
> rest of the locking and lock splitting work is done it's difficult to=
 see
> how any useful progress could be made here). Patches are however welc=
ome.
>
> Alan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-seria=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
