Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18A9322B8F
	for <linux-serial@vger.kernel.org>; Sat,  5 Sep 2026 09:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788601238; cv=none; b=oTpMPjCS2DL+7h4Xu7VAD9r0O7BBN4BYgkI5+KMfSj6BqNhTGZe1GJVjyPTMeuNPsI7am2slKm00JfugcZOxvF51BSX68tAHOjFPyeRmpxKUNSXQjQMDGvnytPWvacHNZSm3rlWNBcc65+HpQYwytjvUf23XNjNJVdZlVgiE4fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788601238; c=relaxed/simple;
	bh=7ZSAOzqjlleseKAqpDhVtW7NiaoMu/+gTZ5b50oWtOc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tnouK+exYZsUwtTo4AhZWaztjjUVPnzOWui9MMYR/ztYHsvKC5Ozb7Wv+ieVKodauEM6/O6Abxi/fBpZOXEJ3jXfe0pwnNTwDPOeX+y8c7Ydjujpt9/uAJa4HrGyHYFiqIc0O0w0FQesA2DRsGO91X8XXz0XGXdCRp+Ndwaj3Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mD7FH84G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mD7FH84G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7811F00A3D;
	Sat,  5 Sep 2026 09:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788601236;
	bh=uC0HCsuDMc8c1DC8JyuEkEjPIS+2tLVoIN11k51mVxo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mD7FH84GWVQcu2myAfUlpMRxy9R0YjyziTcG0l4+Vl/bp3kIP+jaa5CJKmVkdJxHZ
	 l1NCsTOTd6kJ4VXSFS8gjIE9vbv1YTPneTzKz+fCusVvIU9wwjH74k3q6wAi2cSEXi
	 Orb3G+HrISYEJqT1QhiTh1y1ASoJ9d3cI7UPEEaqVgngzJhIiW/EY9Y5z52WPiF11K
	 1jbsKFVPW7Tqd2SvhGUUw5gWImOpAaAKI4goPMm2PwXx1BkbquKCjsM1ctCxBNeiJ6
	 esa7e+J3dL/R0ckFmS25USgBhiRAFn91Z3xjWByLL9MuqhGEXmo5cu2NA25UGvHLn7
	 4PnC5FjML9P7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] tty: sc16is7xx: convert to kthread_run_worker
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bradley Morgan" <brads@mainlining.org>
Cc: linux-serial@vger.kernel.org, media-ci@linuxtv.org
In-Reply-To: <946a190a64560bbb192d03f5757b8349b97157f9.1788513591.git.brads@mainlining.org>
References: <cover.1788513591.git.brads@mainlining.org>
 <946a190a64560bbb192d03f5757b8349b97157f9.1788513591.git.brads@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 09:40:35 +0000
Message-Id: <20260905094036.2E7811F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The explicitly allocated kthread worker is destroyed before the de=
vm-managed threaded IRQ handler is freed, causing a Use-After-Free.

Pre-existing issues:
- [High] Closing any single port cancels the shared polling timer, starving=
 all other active ports on the same multi-port chip.
--

commit 3bc3e4920cc0fac18e8f989a3296c6b4222d065c
Author: Bradley Morgan <brads@mainlining.org>

tty: sc16is7xx: convert to kthread_run_worker
   =20
Convert sc16is7xx to use kthread_run_worker() instead of the
deprecated kthread_run(kthread_worker_fn) pattern. The new API sets
worker->task before the worker starts.

> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7x=
x.c
> index 7107a0fb1e7bb..2cfc1f2900091 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -1186,7 +1185,7 @@ static void sc16is7xx_shutdown(struct uart_port *po=
rt)
>  	if (s->polling)
>  		kthread_cancel_delayed_work_sync(&s->poll_work);
> =20
> -	kthread_flush_worker(&s->kworker);
> +	kthread_flush_worker(s->kworker);
>  }

[Severity: High]
This is a pre-existing issue, but does closing any single port cancel the
shared polling timer for all ports?

In polling mode, s->poll_work is shared across all ports on the chip. If
one port is closed, sc16is7xx_shutdown() unconditionally cancels s->poll_wo=
rk,
which seems to starve any other active ports on the same chip.

> @@ -1705,8 +1702,8 @@ void sc16is7xx_remove(struct device *dev)
>  	if (s->polling)
>  		kthread_cancel_delayed_work_sync(&s->poll_work);
> =20
> -	kthread_flush_worker(&s->kworker);
> -	kthread_stop(s->kworker_task);
> +	kthread_flush_worker(s->kworker);
> +	kthread_destroy_worker(s->kworker);
> =20
>  	clk_disable_unprepare(s->clk);
>  }

[Severity: High]
Can kthread_destroy_worker() lead to a use-after-free if the threaded IRQ
handler fires concurrently?

The driver uses devm_request_threaded_irq() in sc16is7xx_probe() to manage =
its
interrupt, meaning the IRQ handler remains active until after
sc16is7xx_remove() returns and devres cleans it up.

If an interrupt fires or an in-flight threaded IRQ executes in parallel rig=
ht
after kthread_destroy_worker() frees s->kworker, the IRQ handler could call
functions like sc16is7xx_ier_clear() which enqueue work:

drivers/tty/serial/sc16is7xx.c:sc16is7xx_ier_clear() {
    ...
    kthread_queue_work(s->kworker, &one->reg_work);
}

This would dereference the freed s->kworker pointer. Previously kworker was
embedded in the sc16is7xx_port struct, so stopping the task was safe from a
use-after-free, but now kthread_destroy_worker() frees the dynamically
allocated worker before the IRQ handler is disabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788513591.gi=
t.brads@mainlining.org?part=3D3
