Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80BB466AF7
	for <linux-serial@vger.kernel.org>; Thu, 23 Jul 2026 11:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784804727; cv=none; b=lGp7VcEOXvsQbRXJQQan3gqq8qdpiJi304eFq6UqDM+CpQ5vbfFC09Ihfy7WrIGQplFleXAtXEacuS9bq9NK+jdRDXg1w0xqtWRDGspaSi7JsAJYL+FZgSDyQokIU71GV1eeRiHp09rLwY7vnJzVXvmbqkmRGL4YNud+RuqaQxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784804727; c=relaxed/simple;
	bh=Z99f1XCGVjSL9klqfa+LLjusqb2L0TDPTeRLqSmvF6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afSEUG2JkdEqbbxyJ3WFJMojFAFXce1dZyab5lYelbK3tQyo16Ojtb3jdLpjKUj22P2vxAhnsuNKCrGJ6jYREvgmoz7PQ3TGX/dJJEAi6a8wtVzb4oDM/4e9A0NkSiUFTJWtc59775OVettiWX11zNe7+mihrzajN7R659AcVxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RZhXpWww; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RZhXpWww"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4955aa106b1so4839255e9.0
        for <linux-serial@vger.kernel.org>; Thu, 23 Jul 2026 04:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784804724; x=1785409524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vp85x2eRc/psjrLDK8diwI4ryuASXi8rpItu1f+MGS8=;
        b=RZhXpWww88yh4NZhYb6T4Zr7g0gSFEn4WO6pxsW0bZqRv3+16qnM2KRZgn+40c9CoP
         OlHFLhuD5hO0UCE/i7mjQNDDoKdqJKHYMeJZPDTy09DyAL31ZlIZ+Wy0maKyb31Qnw75
         0hG0UwsF/N/hJqC7apyLEVTO0CLev/s0FNBObQKHbtZUajL8lMZ3vqxpkhrO54hisZUJ
         NLrGpD5vYdb7Qb3JuWIVc9bDm84lC4zM+W3oNUK4LGWG2rPh0h72/t6gqbwY+n3srfNR
         dkAiW+H3dhlmK3uAfA+Fwu82jMfQA/EBB2+sIC4iJZWl9LwkF94AHMFV+9VagDbRX182
         cmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784804724; x=1785409524;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vp85x2eRc/psjrLDK8diwI4ryuASXi8rpItu1f+MGS8=;
        b=p3+JJpJ7K0azmfwRsPVysh9wsO0MUGFur9PNC3D+TZxGw9tIlS/D6sOIo+z18l8+Cm
         FSbJMzcw8lGPleaZFtWnB7bdNTDsn3WAYT/FBtAphb0D+wIDLolOCi1fxEoGGh0Ydi7p
         NDgoGRjoVGCekj1YZ9SEAfAcFp3OrHoJQAiTIatYFUfHurivJLfazOP4N3U+oykKbCZE
         fs6IMd1ANxRFXuqjh4KXCyRbov+CPmhjQ8RZiBOFp5DSufZ4NOfTrKtI3FWfhJ1YnQMz
         8/KndpBydBakxkfi9sBGwoQWZLKdL6kBNuzMy+zAbN711sDwAtlCsDOiZtpQCbJ/kRpA
         4etg==
X-Forwarded-Encrypted: i=1; AHgh+RoaOIYwYGPvb42X58T1t5jv85kMa6cmyPBRpPgMFDtuOa9xcLL2Bmh9sUe2neguglPk6Seaq1gScwRNPoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjumT2aZ9ngagfRb8P+GEcjoyGXNUZUMT92EpydJM5QeV0FhTq
	iSkiuQTK5i83pp/+r/s2pGTI4XV4vbUMiJ73/Ic08ceZMshBqT9rImdrdjKWPKhgzqA=
X-Gm-Gg: AR+sD139vH7dQYL3PlWWB6Z7ZObmbeJKV67ECVWvRt0zTp8R1qiQFQ4FEmd6HApn5Z/
	cJdPoLB6CBcbCcTPfJiRE7UGytkgc4qGGW+kUyRiPnRL3vo/NAOeA41ureRBgwq649LmT49+s2X
	d3c5eUa7P7rWAjgg4Pa0myMI2RwR7miVzRWvIhMqbZHGEfnAFbOEzO9xaGQe/o7KSQ+KNfgebmF
	78SopRzapuzcNKAyJ2jT/bpOBFkVSYdYae790mywkd8+abHmjfbAQpEvZHoqgBVBnbxUTrxahep
	yZuOUnFQHw5owXhmNxkfq6m9NEB8q9lDjV5Rh+DBD+Pc9bkzOAkema5o9gNJzBAdaFj4nvQIbxU
	vgdhZ8fAvrqJqgdmcmhNgr/6qP0dhka246oMqBF2UOUEJMfcmYaneX7SDcKUp4SUyhlwXCJydkJ
	YiWDatS9AjSDhVdL0=
X-Received: by 2002:a05:600c:1389:b0:495:5b4f:1efd with SMTP id 5b1f17b1804b1-49573cb983cmr25832805e9.2.1784804723890;
        Thu, 23 Jul 2026 04:05:23 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb57cfsm13971961f8f.11.2026.07.23.04.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 04:05:23 -0700 (PDT)
Date: Thu, 23 Jul 2026 13:05:21 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH tty v8 2/2] Revert "serial: 8250: drop lockdep annotation
 from serial8250_clear_IER()"
Message-ID: <amH1cX5awhnHg99D@pathway.suse.cz>
References: <20260722110925.74387-1-john.ogness@linutronix.de>
 <20260722110925.74387-3-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722110925.74387-3-john.ogness@linutronix.de>

On Wed 2026-07-22 13:15:19, John Ogness wrote:
> This reverts commit 3d9e6f556e235ddcdc9f73600fdd46fe1736b090.
> 
> The 8250 driver no longer depends on @oops_in_progress and
> will no longer violate the port->lock locking constraints.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Makes sense.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
