Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC7718990D
	for <linux-serial@vger.kernel.org>; Wed, 18 Sep 2024 12:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726663945; cv=none; b=LpPDK5/f/IEKwIerVIIFhG9Xxb5BfgJEoJsRSnlXArX8A42E0hpPUCCKaRzCeaV3SlBuom0i4c2RIheTMt75fyUlHfeA3Ee0fKwbnbg2iVLBSPX0oXQhwkjJAKP4xk2U25RIg9KjVCix9CUueYEvhTQ7ZT0a2q/tSSEkG871YCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726663945; c=relaxed/simple;
	bh=5QbounyFpdeLyPpqYbR0StL4YuvH2a6AMVNNNNvb9Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCbgtqKgKzJH+NZUPfK0G6K96VMsry+j5R2uhe4dxUxdeObSgv1K+4c3iETE+cWMW0/MYPyHtfldKhN8C4ADRKFWKDF+iUzZcZ7Y+eDWA7jOec90wUNWdEPNC2cgTD6unp3e/DlOl+L4mIQC91Vb+5T1XTE1y9QF63dvw4W7YzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NgCT4nhi; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NgCT4nhi"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42e5e1e6d37so36052765e9.3
        for <linux-serial@vger.kernel.org>; Wed, 18 Sep 2024 05:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726663941; x=1727268741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+s5jBMUot9g03xEiSgGkzS9qg+YNVwIhQFcEqltV6D0=;
        b=NgCT4nhiqTYFBrzcC9iixqV4la5ZcYUfAPFjOMXQSN0dtPg6wtkLGbszmdGa3h7dJf
         JLGiPTvldGF376yuuctA1BjQIdJPYa2zKvGWS0/lQnMIPOjRHoMrEWOjmVPjIAHGlpjJ
         jam+z2BZtkgQSBbw2BqK4T7t4HM1Z6X4BjQwz5Tjl8Aov8mO3NpO7P778HVNA4T7fYUf
         JY9RarhV2ZQ7f7E5f2RsL5i8AOmOq8tVkR94HtwGrMmSIIrnUdWQaH7wiCbkZTQlLxHR
         yTEhaa22uiArE6WquudZabBtzpk+yOHRaPbcDccQTGq3hnlCZ8Sa7o6UbmvUdocChDMe
         moVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726663941; x=1727268741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+s5jBMUot9g03xEiSgGkzS9qg+YNVwIhQFcEqltV6D0=;
        b=gZfZqzecn+QWZJoXoa9cwIEuUA1G1lTrKw2z7r5NmEqeezGVR1s/BKeFsjbhR9USwv
         ytkX+bWaQCtkC+9yGFlWB5Jq6jm/9CrjroMD6cW37YF/vubasdPZHzvS2lUX0vE2Vih7
         XaZXiP2e35nDoNUe3j9l8giScW6Bx/zUFuePQ49Cz+hNhQLky1Eay7sBpQ0eqwvAMExH
         Pks1qyeokxh+w5kMRVrveTB/tQk6BUXE4b5ATlyXLMqMBLS7R89h5x7RX/XutkzQTh3P
         g9E4tJwBbnzbvNYqhmndpH42g5AYaS9+Vz9XGCuH1jbiHcgqwGAfIRQ1KeE96A01fBAK
         oXdg==
X-Forwarded-Encrypted: i=1; AJvYcCVbx3DXXXoqEgwW8C70Pxl8yT0jPMV+vfOTdhl7bGEKSu5VdeUSxAf2ebLUC1N0dPsjV3CPZvo0vdA8tt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQMK/fPRqDbQ9eWnTIZvHzzJSo85SEm9vbfhFe5OKnja0Z3p+W
	CWA968lO9mHPYwZFKVCWbYLUq5+5hvf+qGtlKUxEVxwqZssjkheAbtbPx6jcID8P/5i/cd5oqRy
	B
X-Google-Smtp-Source: AGHT+IG1ehOCKV8YfrxH+CjYDke8qE4rmuwAM6XvhbWHjYwR2pC+c9kHprUmLkqGKwV66QYZbIfGtg==
X-Received: by 2002:adf:a3c6:0:b0:374:cb30:b9b3 with SMTP id ffacd0b85a97d-378c2cfed36mr11530408f8f.2.1726663941116;
        Wed, 18 Sep 2024 05:52:21 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794601083sm64767585ad.71.2024.09.18.05.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 05:52:20 -0700 (PDT)
Date: Wed, 18 Sep 2024 14:52:06 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Rengarajan S <rengarajan.s@microchip.com>,
	Peter Collingbourne <pcc@google.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH next v2 4/4] serial: 8250: Revert "drop lockdep
 annotation from serial8250_clear_IER()"
Message-ID: <ZurM9ufiMsjT6qKo@pathway.suse.cz>
References: <20240913140538.221708-1-john.ogness@linutronix.de>
 <20240913140538.221708-5-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913140538.221708-5-john.ogness@linutronix.de>

On Fri 2024-09-13 16:11:38, John Ogness wrote:
> The 8250 driver no longer depends on @oops_in_progress and
> will no longer violate the port->lock locking constraints.
> 
> This reverts commit 3d9e6f556e235ddcdc9f73600fdd46fe1736b090.
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Makes sense.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
