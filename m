Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2925B2EC559;
	Thu,  4 Dec 2025 19:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764874930; cv=none; b=AWsQgI3aObPx9UxECfS715G347KRTPP2fU8hgvUcEiuHtwpPxz/URh+W0XTk+YkktEqBGWA8WaM6LPzNQAash2sWKYnyDRqk/R9TU9BiDCyfERnWW4GxmTPbAZqOlG6sXfjCwVazebDkIHcpnOsFC3996442XmkarY5xiwHnpx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764874930; c=relaxed/simple;
	bh=RcMWe4exMIgmcmYhi8176R/T8l21VP2QGILCZqCj2/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PWvQSQEXO56IbgpQZ/h1D3UHH+N1QrJy/XZWKyk34i4nWDAkLp0jx9PyyON1YFNJjf7C3+fD+ilauImzu4apcon8eftGEErq9ePmp8MOlMgJ5mRUQtN9c1w5ubchO/fk+3dB2LTuGnj7EUUKYjkQ/kyE8wmubK8gIULkBqW0XwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lanFRIWz; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lanFRIWz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Fj
	G7CpwsF3/2uQdNTSt1lq5s2Va9lNyVRpA+0s/u/IQ=; b=lanFRIWzVHACzjFA9B
	MtGsIhA5OkQMbvIn5LxIYgMclGec3/1z7KVQLvlrWgpH8Kh3kT94aQ4zI+lTcSPm
	uHw7PzFeVvVBdKtjk7SHhN+p5BxrIUIYcWt8Sj2wqihb9t12MIsZCOUK0Ss4zomP
	d1TD4rq6SHeVs6iZJqBZ6IRMI=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDXYoWD2jFpqh7DDw--.2825S2;
	Fri, 05 Dec 2025 03:01:24 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: tj@kernel.org
Cc: gregkh@linuxfoundation.org,
	hch@infradead.org,
	jackzxcui1989@163.com,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v4] tty: tty_port: add workqueue to flip tty buffer
Date: Fri,  5 Dec 2025 03:01:23 +0800
Message-Id: <20251204190123.1541283-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aS58X-1-Izo237HY@slm.duckdns.org>
References: <aS58X-1-Izo237HY@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXYoWD2jFpqh7DDw--.2825S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFyxWr1xKr13ZrWxKFWUCFg_yoW8Ww18pF
	WfKry7Ga1Dtr47tr90vw47uFyrWw1DZ34Y9r47Xa4DZr909as0gw1agryYvF45Cr1rX3ya
	yasay3ZrCa4qvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piyxR3UUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbiGR0aCmkxzNpdXwABsZ

Dear tejun,
    Sorry for reply late, working on another urgent task recently.

On Mon, 1 Dec 2025 19:42:55 -1000 Tejun Heo <tj@kernel.org> wrote:

> On Sat, Nov 29, 2025 at 02:10:48AM +0800, Xin Zhao wrote:
> > +	if (!(driver->flags & TTY_DRIVER_CUSTOM_WORKQUEUE)) {
> > +		driver->flip_wq = alloc_workqueue("%s-flip-wq",
> > +						WQ_UNBOUND | WQ_SYSFS,
> > +						0, driver->name);
> > +		if (!driver->flip_wq) {
> > +			error = -ENOMEM;
> > +			goto err_unreg_char;
> > +		}
> > +		for (i = 0; i < driver->num; i++) {
> > +			if (driver->ports[i] && !driver->ports[i]->buf.flip_wq)
> > +				tty_port_link_driver_wq(driver->ports[i], driver);
> > +		}
> > +	}
> 
> Maybe it's just me not understanding the requirement but does this need to
> be this complicated? It was just using system_unbound_wq before. Can we
> start with something very simple - ie. one custom workqueue which is shared
> across devices? Wouldn't that work?

Are you suggesting that all tty ports in all tty drivers/devices use the same
workqueue? This would prevent me from individually setting the CPU affinity
attributes of ttyS's flip buffer, as it would affect other flip buffer like pty.
In our project, we do not want to modify the work affinity attributes of pty's
flip buffer, as it is not critical and should not be treated specially (being
placed on CPUs with relatively fewer real-time tasks or having its priority
increased).
More broadly, if a system has multiple tty devices, different tty devices may be
running unrelated workloads bound to different CPU groups, it is more reasonable
to allow the flip buffer work related to the relevant CPUs, rather than putting
them all into a single workqueue.


--
Xin Zhao

