Received: from sonata.ens-lyon.org (sonata.ens-lyon.org [140.77.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3118341F37F;
	Thu, 24 Sep 2026 23:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.77.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790294032; cv=none; b=WQqScfFotL7D++Z2uZS+JDpllQSfLUtpaPBmOvHyiVf9P1PnL2LpJOZpn8bxkCrPK3MQdk4YWJ7fmH+gQ1bx3n605awRfKsXvfdxIRJrl8ciSpFZjJVdkNJ2vB1nEDuclmjG0dNAQ7ITdBZMOBbF8F88Uctf5Ov3UZgdYmlrgLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790294032; c=relaxed/simple;
	bh=Y/moXp8VReBpllKRS1BPunMWKD4QIxlzxHHvCbVzkEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttJckq3mOD4FV8S19NTACTPK/F3HHv9S1Rrs6h8P/tM45Tfd10nI6dVR985S5os2sTowhK53S7kDW0tIcgvAnJz5GXILpFU3nAINgQ9xFl5WGuWrbQYsRTqVqKkUtiY4Ql9qNWUjPbkH4Tk0I55sMF5oGjNXUpc8KK4l4by1WYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org; dkim=pass (2048-bit key) header.d=ens-lyon.org header.i=@ens-lyon.org header.b=H2/gmDFb; dkim=pass (2048-bit key) header.d=ens-lyon.org header.i=@ens-lyon.org header.b=gaCZN1Q2; arc=none smtp.client-ip=140.77.166.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ens-lyon.org header.i=@ens-lyon.org header.b="H2/gmDFb";
	dkim=pass (2048-bit key) header.d=ens-lyon.org header.i=@ens-lyon.org header.b="gaCZN1Q2"
Received: from localhost (localhost [127.0.0.1])
	by sonata.ens-lyon.org (Postfix) with ESMTP id 19E75A492E;
	Fri, 25 Sep 2026 01:53:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ens-lyon.org; s=dkim;
	t=1790294029; bh=Y/moXp8VReBpllKRS1BPunMWKD4QIxlzxHHvCbVzkEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H2/gmDFbEoKmDKXPJ57r3MUaiDptf8okbfZAuW5NLjgoqaEnq04xYrZxZPb6THVM0
	 jHYasiv2E0vOsSYosTpbqXY4g3mBfQQ4AMNqzQQbS5HHJBjx+dBuHOUAiQJIdR7t42
	 KQo1KkTLtlsb45NuTrMyxm+ad3hVP393+7wo8zLMHvIsTmfXxUTm8NykYrRSdTpn3C
	 DY3WSVwtGApKf4M6zjw52JIJ+tPqSpxDmydfPPobrl8jnuhWl0nH9+azITmpiX4lnH
	 tUR7NPfVYBzX0AX0qbYlW0vITNOusYkxSFgKGYgegJD0RsDzBc3OYV6NYtL7dJVTcO
	 hZXuSdc4KhgFQ==
Received: from sonata.ens-lyon.org ([127.0.0.1])
	by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rkLvCz5llTAr; Fri, 25 Sep 2026 01:53:49 +0200 (CEST)
Received: from end (lfbn-bor-1-980-210.w90-120.abo.wanadoo.fr [90.120.173.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by sonata.ens-lyon.org (Postfix) with ESMTPSA id 05E42A4903;
	Fri, 25 Sep 2026 01:53:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ens-lyon.org; s=dkim;
	t=1790294028; bh=Y/moXp8VReBpllKRS1BPunMWKD4QIxlzxHHvCbVzkEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gaCZN1Q2P3z0OkbgW31eeLPLFZHZ90Uupkrz9rdHaaIl/qh21XHEMkE8LQrbx4ypQ
	 t1vgvngIq/qlAxe7hjWYcXfewoWxKcZHeuDOpdTibMYxAAl+2Kl35ZO4nx9pwtsNlt
	 HUjWtgkwyNlx2tyHGPLNZaUSMeSFM+39V0ABKgK7mL5SBkpvkqr+LchnJ0isbiSvKq
	 kgjb1ZYHapYoAqn1J1heMFh1vBBZKaB0jQugWQeeZd9S2qdgtLpWux+TXTJIkC/6KJ
	 JYN/bfyXuHUdaToWSjbvAZTTPsUN+7pGMVk4oIZPI9cjr6g/gxa1phbv1CgeJIS4ik
	 H8Ha0wt+Hfi3Q==
Received: from samy by end with local (Exim 4.100)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1x9tG7-000000001wr-0Q46;
	Fri, 25 Sep 2026 01:53:47 +0200
Date: Fri, 25 Sep 2026 01:53:47 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Fushuai Wang <wangfushuai@baidu.com>, Kees Cook <kees@kernel.org>,
	Stepan Ionichev <sozdayvek@gmail.com>, linux-serial@vger.kernel.org,
	Manuel Lauss <manuel.lauss@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] braille: nbcon: Allow using a serial driver
 converted to nbcon API as a Braille console
Message-ID: <arW4C9TYane57IGN@end>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Petr Mladek <pmladek@suse.com>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Fushuai Wang <wangfushuai@baidu.com>, Kees Cook <kees@kernel.org>,
	Stepan Ionichev <sozdayvek@gmail.com>, linux-serial@vger.kernel.org,
	Manuel Lauss <manuel.lauss@gmail.com>, linux-kernel@vger.kernel.org
References: <20260922072558.98854-1-pmladek@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922072558.98854-1-pmladek@suse.com>
Organization: I am not organized

Hello,

Petr Mladek, le mar. 22 sept. 2026 09:25:56 +0200, a ecrit:
> Note 3: I do not have any device to read the Braille output so I am not
> 	sure if the output is correct. I just checked the output on
> 	the serial console and it is a bit suspicious. It looks like
> 	it prints every message N-times when N is the length of the string.
> 	And it adds one character in each iteration, for example:

That is actually expected: braille displays don't show the whole log of
what was printed, it only shows the last print. Getting it printed on
each character output is expected if characters are printed one by one,
the device will show the text as it gets printed.

Thanks for fixing this!

With regards,
Samuel
