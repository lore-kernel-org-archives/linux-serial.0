Received: from va-2-36.ptr.blmpb.com (va-2-36.ptr.blmpb.com [209.127.231.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7CA293B5F
	for <linux-serial@vger.kernel.org>; Wed,  8 Jul 2026 07:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783496038; cv=none; b=BKos+crK30MTinoOUT5kAw/EETdvRlgBCDiWpQshmn4ZuA5KRZc26zF+o9IoRzRKYliRwFmNM1vzByH8WNLixWsRbI+9a1VnWbR/cYcAHQQAoFTnQmW28z3/xS38Si0iiDqM4l1rjQDysY8obY6e43EPMrV3rg0UiqxwdauzlvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783496038; c=relaxed/simple;
	bh=1OS4Ye+cS0oIuNv1QC/5bSBIi5SQQjKdlwgtz1cC0pc=;
	h=To:Subject:Mime-Version:Content-Type:In-Reply-To:Date:Message-Id:
	 Cc:From:References; b=tqybfKWBqh+wQp2zPhV1Z0/REWlVw8P42oLp78gYXp2/cVnDp8XCZHOYGq4+ND8zSYJHaeiOHXWS3oKZnJsy1arAfk/VtklgS1Mc3Le+DT5xYqxFCoFX9mVF1e8xBUovgJMmvixI516ij9eFbBGtld37xmmvo4oDGJ5IVpmXPes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=OAqy6g6Z; arc=none smtp.client-ip=209.127.231.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="OAqy6g6Z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1783496019;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=1OS4Ye+cS0oIuNv1QC/5bSBIi5SQQjKdlwgtz1cC0pc=;
 b=OAqy6g6Znofn4+Cw0Pqwbe6Ev8KK0Ya29W/nkisC3++lMARAOBlMtKtHGDrGggzh97RuAj
 kDaVnRxw9Nikittz9KKiY1U1jVk3ZCvNT5CvtBNaEvaEuHx9L/MPq3cUfqU1qtUMHNxuWk
 Qpo2/UkpVzSNIDuP3wB1RBAYeYi9x8mSwRP8acyXWOUqIdZh3Lpp6U5d20OuZHbPcIrEwp
 ca+uI/7WJfGjvtwIbbA0MzIkLVQNj/fX3RBHg+hf11r5urnuvXH0tRIHk2imrKtUH658yA
 YuzdyiTK1kIRqLS2LYZKIf75QpmOV0HrzxzZ5yx+F4BS9xkfG004QpYfI4yyZQ==
To: "Jiri Slaby" <jirislaby@kernel.org>
Subject: Re: [PATCH v6] serial: 8250: fix use-after-free in IRQ chain handling
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0ede8499-abe2-41d3-bb0c-095c02c5b699@kernel.org>
Date: Wed, 08 Jul 2026 15:33:36 +0800
Message-Id: <5cf37150673ea4d5c28f94db91cdf68504b50522.0e091ec2.1d26.4eb2.8da3.53f8a6520707@feishu.cn>
Cc: "Qiliang Yuan" <realwujing@gmail.com>, 
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, 
	"Anton Vorontsov" <avorontsov@ru.mvista.com>, 
	"Alan Cox" <alan@redhat.com>, <linux-kernel@vger.kernel.org>, 
	<linux-serial@vger.kernel.org>
From: "Wang Zhaolong" <wangzhaolong@fnnas.com>
X-Lms-Return-Path: <lba+16a4dfd51+8b698c+vger.kernel.org+wangzhaolong@fnnas.com>
References: <20260707-bug-221579-8250-shared-irq-race-v6-1-f8c499a90bdd@gmail.com>
	<0ede8499-abe2-41d3-bb0c-095c02c5b699@kernel.org>


> From: "Jiri Slaby"<jirislaby@kernel.org>
> Date:=C2=A0 Wed, Jul 8, 2026, 2:04 PM
> Subject:=C2=A0 Re: [PATCH v6] serial: 8250: fix use-after-free in IRQ cha=
in handling
> To: "Qiliang Yuan"<realwujing@gmail.com>, "Greg Kroah-Hartman"<gregkh@lin=
uxfoundation.org>, "Anton Vorontsov"<avorontsov@ru.mvista.com>, "Alan Cox"<=
alan@redhat.com>
> Cc: <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>, "Wang=
 Zhaolong"<wangzhaolong@fnnas.com>
> Ah, now I see you are fixing the same thing as:
> https://lore.kernel.org/all/20260708031115.3757150-1-wangzhaolong@fnnas.c=
om/
>=C2=A0
> I did not look up who of you was first.
>=C2=A0
> But:
> Reported-by: Wang Zhaolong <wangzhaolong@fnnas.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D221579
>=C2=A0
> Looks like he reported and apparently tries to fix that too ;). You were=
=C2=A0
> obviously CCed, talk to them and don't send two patches for the same issu=
e.
>=C2=A0
> On 07. 07. 26, 16:06, Qiliang Yuan wrote:
> ...
> > --- a/drivers/tty/serial/8250/8250_core.c
> > +++ b/drivers/tty/serial/8250/8250_core.c
> > @@ -131,10 +131,11 @@ static void serial_do_unlink(struct irq_info *i, =
struct uart_8250_port *up)
> > =C2=A0 =C2=A0* - allocate a new one, add it to the hashtable and return=
 it.
> > =C2=A0 =C2=A0*/
> > =C2=A0 static struct irq_info *serial_get_or_create_irq_info(const stru=
ct uart_8250_port *up)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0__must_hold(&hash_mutex)
> > =C2=A0 {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct irq_info *i;
> > =C2=A0=C2=A0
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0guard(mutex)(&hash_mutex);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0lockdep_assert_held(&hash_mutex);
> > =C2=A0=C2=A0
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hash_for_each_possible(irq_lists, i,=
 node, up->port.irq)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i->i=
rq =3D=3D up->port.irq)
> > @@ -151,19 +152,37 @@ static struct irq_info *serial_get_or_create_irq_=
info(const struct uart_8250_por
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return i;
> > =C2=A0 }
> > =C2=A0=C2=A0
> > +/*
> > + * serial_link_irq_chain() hooks the given 8250 port into the IRQ chai=
n.
> > + *
> > + * hash_mutex must be held from the hash lookup through the first
> > + * request_irq() completion. =C2=A0Dropping it earlier allows a concur=
rent
> > + * serial_unlink_irq_chain() to race in after i->head is published but
> > + * before the IRQ is fully set up =E2=80=94 another port sharing the I=
RQ can then
> > + * join the chain and run the shared-IRQ THRE test while IRQ startup i=
s
> > + * still in progress, triggering an "Unbalanced enable for IRQ" warnin=
g
> > + * in kernel/irq/manage.c.
> > + */
> > =C2=A0 static int serial_link_irq_chain(struct uart_8250_port *up)
> > =C2=A0 {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct irq_info *i;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret;
> > =C2=A0=C2=A0
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0guard(mutex)(&hash_mutex);
>=C2=A0
> hash_mutex is no longer an appropriate name for this lock.
>=C2=A0
> > +
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i =3D serial_get_or_create_irq_info(=
up);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (IS_ERR(i))
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return P=
TR_ERR(i);
> > =C2=A0=C2=A0
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Serialise against the list manipulation=
 in the interrupt handler
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 * and in serial_unlink_irq_chain(). =C2=
=A0hash_mutex is still held which
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 * prevents serial_unlink_irq_chain() from=
 entering and freeing the
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 * irq_info until the first request_irq() =
completes.
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 scoped_guard(spinlock_irq, &i->lock)=
 {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i->h=
ead) {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 list_add(&up->list, i->head);
> > -
>=C2=A0
> Unrelated change.
>=C2=A0
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 return 0;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> > =C2=A0=C2=A0
> > @@ -171,11 +190,14 @@ static int serial_link_irq_chain(struct uart_8250=
_port *up)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i->head =
=3D &up->list;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> > =C2=A0=C2=A0
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D request_irq(up->port.irq, serial82=
50_interrupt, up->port.irqflags, up->port.name, i);
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret < 0)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D request_irq(up->port.irq, serial82=
50_interrupt,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0up->port.irqflags, up->port.name, i);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret < 0) {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 serial_d=
o_unlink(i, up);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> > =C2=A0=C2=A0
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>=C2=A0
> Unrelated and mainly unneeded change.
>=C2=A0
> thanks,
> --=C2=A0
> js
> suse labs
>=C2=A0

Hi Jiri, Qiliang,

Thanks for looking at this.

From my side, I do not want to make this a patch ownership discussion.=C2=
=A0 I have
sent my v3 here:

=C2=A0 https://lore.kernel.org/all/20260708072306.3921604-1-wangzhaolong@fn=
nas.com/

It addresses the lock rename comment, keeps the change focused on the requi=
red
locking, and has been verified again with the QEMU ttyS1/ttyS3 shared IRQ
reproducer.

My main goal is simply to get this reproducible mainline regression fixed
soon, because with panic_on_warn=3D1 it breaks my regular build/regression
testing.=C2=A0 I do not have any promotion or credit pressure around which =
patch is
taken.

So I think the choice should be left to the maintainers.=C2=A0 Please take =
whichever
version you think is the better basis for mainline.

Thanks,
Wang Zhaolong
