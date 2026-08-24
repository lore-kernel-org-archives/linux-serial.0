Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C81836194F
	for <linux-serial@vger.kernel.org>; Mon, 24 Aug 2026 15:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584990; cv=none; b=OU5BppqwPkMQYBvuQ4fWskC77Cihv7pbifMcYcFVfbrS38KGe4Fx+P/zSiS95pvwRNtLPLweMPYoEchKCySrfcg1oTEhBIhPNS6W8b/QQGb9JiyB8+DM/Jip2SUI/106uyoj2HTHGnho1XCFq4sRBOPQMNSAqwordBGHF0j0WRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584990; c=relaxed/simple;
	bh=wU19ziy1iAYVrIaeFDa0RBjJh1rlBqYBIPe9hi5333Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t5Ag4lVLBqxRbE+HOiVhzlZwu32eDa9mEMLFan4Uw6rSdJRUlSiBWWzSYFzWNo0TFt8iO8O1X81D1M7ll74fViz/SEAzrQr3CfgCS4Y3rfUg41Yh9CWPiZ4jOYBDBpuoUHTbusUAbbZz7pYAYG4MhCyC7cG3VB28LMJr7//EvUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkdhBnfZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkdhBnfZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5171F000E9;
	Mon, 24 Aug 2026 15:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787584988;
	bh=EDNMFyLaR0J51Sa546Ld6IJ+RIU7geZVGT8JTljeDv4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RkdhBnfZhuRouIDMiD+2DKDqkBUSxIT5RUJVQGyjEWaH1vn3dx8hi3MA6RYiPRP11
	 evFkzBKaYVZQ/ybpQ865Wj00xZG+EG/B3IfVJjfqAjVpnZ0Rv1ebi7biak/pHJiYnT
	 8FDQjJa51s6EzYJ9xGrcLFMqq3r61rmx7oqrFXjyyKSraDVcNbuBIdD1YFffoiL5PJ
	 CF2IRy7L9wNWKrb1MbbtOWLSzX21C6LSbvlyQlxgC7el3RiKcM7z+0AiY8SIVt9Kpx
	 10QdHkyKB6LcjnvvoG45Jc0X+z4OHfIb8OuQBo8uCJnFynDZS1WZf1Qz3NoGBrJofa
	 FaWnyzgYyJKEg==
From: sashiko-bot@kernel.org
Subject: Re: [BUG] KASAN: slab-use-after-free Read in __timer_delete
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jaeyoung Chung" <jjy600901@snu.ac.kr>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260824145314.2148275-1-jjy600901@snu.ac.kr>
References: <20260824145314.2148275-1-jjy600901@snu.ac.kr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 15:23:08 +0000
Message-Id: <20260824152308.CB5171F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] The proposed patch does not fix the reported issue, but instead in=
jects a 600ms busy-wait reproducer delay into the kernel.

Pre-existing issues:
- [Critical] Unlocked concurrent configuration ioctls and receive paths rac=
e to allocate and assign DLCIs, causing memory leaks and a Use-After-Free.
- [Critical] Concurrent execution of gsm_cleanup_mux() leads to a double-fr=
ee of DLCIs.
- [High] gsmtty_cleanup() drops the reference of the wrong DLCI 0 if it was=
 concurrently overwritten, leading to a Use-After-Free.
- [High] gsm_dlci_free() unconditionally clears gsm->dlci[dlci->addr], orph=
aning new DLCIs and causing a NULL pointer dereference in gsmtty_install().
--

--- Patch [1]: [BUG] KASAN: slab-use-after-free Read in __timer_delete ---
commit 64a236e2cd258e423904f320e674b1fd4365d267
Author: Jaeyoung Chung <jjy600901@snu.ac.kr>
Subject: KASAN: slab-use-after-free Read in __timer_delete

This patch attempts to address a regression in __timer_delete found
by a race fuzzer. It provides a reproducer and a delay patch to reliably
trigger the race, rather than a root cause fix.

> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index c13e050de83b1..db5b56e82eb26 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -52,6 +52,8 @@
>  #include <linux/uaccess.h>
>  #include <linux/module.h>
>  #include <linux/timer.h>
> +#include <linux/delay.h>
> +#include <linux/sched.h>
>  #include <linux/tty_flip.h>
>  #include <linux/tty_driver.h>
>  #include <linux/serial.h>
[ ... ]
> @@ -2677,6 +2679,9 @@ static struct gsm_dlci *gsm_dlci_alloc(struct gsm_m=
ux *gsm, int addr)
>  	} else {
>  		dlci->data =3D gsm_dlci_command;
>  	}
> +	if (addr =3D=3D 0 && strncmp(current->comm, "syzrepro1", 9) =3D=3D 0) {
> +		mdelay(600);
> +	}

[Severity: High]
Is this intended to be merged upstream?

The commit message notes this is diagnostic code to reproduce a race
condition rather than a fix.

Can this stall the kernel if triggered by an unprivileged user interacting
with the tty interface?

>  	gsm->dlci[addr] =3D dlci;

[Severity: Critical]
This is a pre-existing issue, but does this unlocked assignment lead to
memory leaks and orphaned timers?

Multiple threads can call the configuration ioctl concurrently, which calls
gsm_config() -> gsm_activate_mux() -> gsm_dlci_alloc() without holding any
locks. A network receive path via gsm_queue() can also call
gsm_dlci_alloc().

If one thread allocates a dlci and another thread unconditionally
overwrites it with a new dlci here, the first dlci is leaked. If the
first thread subsequently calls gsm_dlci_begin_open(), the leaked
dlci's timer is armed.=20

When the mux is destroyed, the leaked timer is never stopped, which can
cause a use-after-free regression when the timer fires and accesses the
freed gsm_mux.

[Severity: High]
This isn't a bug introduced by this patch, but does overwriting the dlci
array concurrently also cause reference counting regressions in
gsmtty_cleanup()?

In gsmtty_install(), a reference is acquired via dlci_get(gsm->dlci[0]) but
the pointer isn't cached for cleanup. If a concurrent configuration ioctl
overwrites gsm->dlci[0], gsmtty_cleanup() will call dlci_put(gsm->dlci[0])
on the new dlci instead of the one it originally referenced.=20

Could this prematurely free the active control dlci while it is still in
use?

[Severity: High]
This is a pre-existing issue, but can this also lead to a null pointer
dereference when freeing these objects?

When an old dlci is overwritten and finally freed, gsm_dlci_free() executes:

    dlci->gsm->dlci[dlci->addr] =3D NULL;

This destroys the pointer to the newly active dlci. A subsequent call to
gsmtty_install() will read gsm->dlci[0] as a null pointer and pass it to
dlci_get(), which passes &dlci->port to tty_port_get().=20

Since evaluating &NULL->port results in a non-zero struct offset, the null
check in tty_port_get() is bypassed.

[Severity: Critical]
This is a pre-existing issue, but can concurrent ioctls trigger a
double-free of these objects during cleanup?

If two threads call the configuration ioctl concurrently, they can both
trigger gsm_cleanup_mux(gsm, true).=20

The first thread acquires gsm->mutex, iterates over gsm->dlci[], and calls
gsm_dlci_release() to drop the refcount. If the refcount does not reach zero
because ttys are still active, gsm_dlci_free() is not called and the array
entry remains a valid pointer.

When the second thread acquires the mutex, it observes the same pointer
and calls gsm_dlci_release() again.

Can this drop the active references prematurely and free the dlci while
ttys are still using it?

>  	return dlci;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824145314.2148=
275-1-jjy600901@snu.ac.kr?part=3D1
