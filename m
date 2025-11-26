Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8681B2D060E
	for <linux-serial@vger.kernel.org>; Wed, 26 Nov 2025 13:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764163372; cv=none; b=DQm+8PqcRPl6qv7We2NC0dgqfzuxf4fIYqcYkQobSfSjiqPXBiQlgyISAfS0FaZbh/y/HR65zWzQrsr6jakug0owt+MVS2eNUvnlbCWvqhIN835jue3Z3uVCO8K9McLKiNtjPS1LAU0JSZ33nxqEIxPGuRgsP/1XSNC++hopgCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764163372; c=relaxed/simple;
	bh=rsQmV307FIzJtWZNxvKq2p6dQfgx6t5kUN2PBnuPCXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+cWwnSEm0zlUEA2nTX2/nDIVPG2fBh/n92atSL9gmloeHsNXB/gwSVAhdnD/aCyEzHoXrEE+owt+82rLtz8YX70wiwh2pK/ILXM+1oCMpKav2vpCO37fzpALQXPLgVfHsvjveuj0oQsxNP9C8dbaJIr+TWe2YFyJhwOAibHrC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ii/Wma8i; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ii/Wma8i"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42b38693c4dso2942082f8f.3
        for <linux-serial@vger.kernel.org>; Wed, 26 Nov 2025 05:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764163368; x=1764768168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I+mhDkufW6jQ5YRScCzzhwHbJH9j3fMQKiq5R61ePjI=;
        b=Ii/Wma8iVR3tH0x8Xq4ZzD5zCOxdsUK6hrSvGVpSKyYeQFyTJoAutP5+9XjbTHLpjD
         kf+mauA1wv2fA/1fvNlx/a75g6AXKnmPZii2f3gADpKrTXHSZqxgitYdMfzz9estN/ny
         JJ/ZWe0XkLhSCoYhohY+pRfRI6trJv5Ihn4yZ4GaB1apUDJeYZ/a/cZYXN89yYoQu5R5
         zRnKr8rK1atNDAYlH4SE/Xo8BUtquA+bfU1EJgfAvfjIoX2ZuEoTaz3IIuwkzN2JBFoS
         KNDikXBKx3UR9iHZVuvSNfF+JaeFUo3I8mW6t0bIpyomDNGLgmSd2aajYwGYmTgwqDi/
         erFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764163368; x=1764768168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+mhDkufW6jQ5YRScCzzhwHbJH9j3fMQKiq5R61ePjI=;
        b=WYePjJOvyPk06lU8jfH3nwIGZQTAhu3PGdeL16SqSoyERB9eiBrdkzIO8DAqUzu8hW
         27HzWgJHCufc3Qf64cB6adPN+V0aAfd8P+sEVXBpA8Rq8h2mlg1eOaazvX7P7T1sMfR6
         jLwhKuORBe6KatBx8DdSPaU1WIROMFACpBHCCt3mfKDjmqUH8bpV3i3sCqcxSXpe1erM
         zxcCXS3+7vSlAkLj6yS+9bwIL/isqtOjOJD4oTz+j3Tt9Bb21GO23eAPglJdB9upUeyC
         wR+6/bAGMSSN83nij0ptOEQ0RCJjjUuYSuDVdHO/2tb7swXU511pNXQ0aOywac6E8S1d
         E0uQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxqwKUa4sEJCcWZglxBx1A4cKDuiSeQ6dBq6M6tnIM43Nr37OJcbC6K/MSHs5AvtzvCyHQuQBILfJ7fHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkAZEpRKYa9/dbIG7MZ61FEH95UDbZIbAzhedq9/MyXb2K9T9R
	LWv91XeD7R9EcvPNKIsu0pOuMfBUNku+uAbqMzd7Uxe+grPi1+FwQRR3OrnLBtHuBAY=
X-Gm-Gg: ASbGncss9pGj2WXmUQZZ7lyZrjKQxx7fgwQf2MR44Cdim5HxY1lHQLdl5/ilHn+M3B6
	Kns+EeE/7DLLu6T4Tc4LVB0cTdgwOvyx+7wSxs062tzzgtI8cQkc/dOFkmOsC/Hp+05rj/DokFy
	FaIjpgk4CjNY2/5ytqIx1DfvbU12aEDRB+68bosa688RY2KlR+4+EJfQBV2aEe8v/RpFHaAZMv1
	36DljCgp9r5+1IiRbHsECXm7Z1nQqagmMgIdxeLYGO6DMODThyLv3ovuUHJcce8V7kGNKw3Itfm
	dIwDhUFB/IaAV6N7ekEOiDIeTLkQNGfIufS7BJ6NSfb0sFts88fAt3wVOyCK6htBRpxZRqWDbzr
	zFPQuaJy7BVvMBa4G/QtWZMvW6u2QHdaXQZaMIx8cEyTGt+JKmgKeVdXW+YOTdocAGjsRMdYvXO
	OiwkfjNXtACvtURQ==
X-Google-Smtp-Source: AGHT+IGJcihhcxfNfd8mIQtL0Z/0hLrPGwpypQO8Ri9oGZbHR7NXbvwNhm6TwKmffccOm4pb+YONkw==
X-Received: by 2002:a05:6000:2288:b0:429:c4bb:fbbb with SMTP id ffacd0b85a97d-42e0f2129cemr6983138f8f.13.1764163367783;
        Wed, 26 Nov 2025 05:22:47 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fa3a81sm41314165f8f.26.2025.11.26.05.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 05:22:47 -0800 (PST)
Date: Wed, 26 Nov 2025 14:22:44 +0100
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-um@lists.infradead.org
Subject: Re: [PATCH v2 2/4] arch: um: kmsg_dump: Use console_is_usable
Message-ID: <aSb_JDBBX9Yh0jCM@pathway.suse.cz>
References: <20251121-printk-cleanup-part2-v2-0-57b8b78647f4@suse.com>
 <20251121-printk-cleanup-part2-v2-2-57b8b78647f4@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121-printk-cleanup-part2-v2-2-57b8b78647f4@suse.com>

On Fri 2025-11-21 15:50:34, Marcos Paulo de Souza wrote:
> All consoles found on for_each_console are registered, meaning that all
> of them have the CON_ENABLED flag set. Since NBCON was introduced it's
> important to check if a given console also implements the NBCON callbacks.
> The function console_is_usable does exactly that.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Makes sense:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
