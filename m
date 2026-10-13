Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7723E51B17C
	for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 15:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906898; cv=none; b=VvJJO+Fe8UbAKVkQg4wQYRy4xNxA5P8qHkflatAGFuuEK7QeWiX1Er9GA2l9+45IVkOJb2Wk48qoAIdCT6V0p6NzFVUAI9G45BY5BL+j8UlV73fVtDkva0kdVm5fGTgHQzEnvX3FPAQl7IA/Q0FI1Ac7GbYbMyncABdlzfSq5R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906898; c=relaxed/simple;
	bh=OsQ9IHcTvBEPOvp3WcZ7NeDN9M6ycgHgABucE1HqDdk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=P98uusv/5Y0U2+TayA+qlnOoOlBjLygjSFAQUkPup9bZWpzP+4hZXdJxyoP9DVnBP/O24PqCpkg45VBCa9OiK5/u/EO9Y3L3MfMKpwaHfj7U4Lsdzu0496UTt6kvQCt2C1s4Rnfv500j9yW2oH0f10YobdXVFsFDlUihskk1C8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2EHBObC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2EHBObC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15BC1F000FF;
	Tue, 13 Oct 2026 15:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791906897;
	bh=OsQ9IHcTvBEPOvp3WcZ7NeDN9M6ycgHgABucE1HqDdk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e2EHBObCbftrEUOZZk2XSngiqT25M7HdX7fSxYzC/YgOjd24n1gRtxD5kD1zd/tOk
	 asFyidswJ2GKl6A8JXiuy9j9Z6dAOQZCuIf1adyDBP8A2o1aMKEvoc+pp7tIla7czw
	 dy7tAo32QdFdd4KvuK4tcCY5ecXoONkFUqqyIPFt8tipA/cPWmV98f8usgL32cIZaY
	 EC2+hknLxRiUbVGmU00UJzhpmhf1LrnSJY7j8GuXSY+zOK5vQwVdS4036SyNhoY4GG
	 h8ZMQwF8XROaKnZyFI6tw9pJR2yr0UPtj2fIk8zxer+Q9QWCYpiUvb6Djdddz0PTrG
	 DZ/98Kc0eCxdA==
Message-ID: <sashiko-outbox-170061@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] nbcon/reboot: Switch NBCON consoles into the
 emergency mode in emergency_restart()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Petr Mladek" <pmladek@suse.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261013154141.94016-1-pmladek@suse.com>
References: <20261013154141.94016-1-pmladek@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 15:54:56 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> When the system is going down a normal way, the NBCON kthreads are
> flushed and stopped properly via a syscore shutdown callback, see
> printk_kthreads_shutdown().
>=20
> One missing piece is emergency_restart() where the kthreads are not
> stopped. It might be called from several non-panic code paths,
> e.g. sysrq-o, kdb_reboot(), or some watchdogs.
>=20
> Fix it by explicitly entering the emergency (atomic) mode and trying
> to flush the consoles there.
>=20
> Note that printk_trigger_flush() must be used instead of pr_flush()
> because the later is not safe in an atomic context.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/all/202608061008.48a1e76e-lkp@intel.com/
> Suggested-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013154141.9401=
6-1-pmladek@suse.com?part=3D1

