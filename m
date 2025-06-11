Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB3027815D
	for <linux-serial@vger.kernel.org>; Wed, 11 Jun 2025 14:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749652716; cv=none; b=AQDQNbgkz1ODJGLjXkeaqyMzdU95cjbs1Oi9Gr4anXu6556lyAqpXjpoti8sHJt2ICo/igP/GA/+OO8KqSgYi3UsJfKZqpk+eiPvNBr8c1rdDHNFmIn4EflNU9jnHZnlXyP5wCr0XfeVeePNjXcypFAMHvRXc3/IxBSnst2KfHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749652716; c=relaxed/simple;
	bh=DDbLBH2b0Du1LQLMF4T/yVMhsv/G95JHEgrJ0ODJBWc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XOgwUCVCIVhttL+iJJ88nQixXcSi5uhmZ2kIxua9QKaN1XeXExPm10gOhk+IG/nvUKLmMyTeNWSEIZCOPuhe3+0phjqmZ/oBOZ1/0FiV5EMX4wjpFsLpamAmm9+jl7MHQkJuVWPKjzVojec0om+rtSRtBbpRiwpDJzV69kUqUjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mdyooSaX; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mdyooSaX"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c59e7039eeso942445385a.2
        for <linux-serial@vger.kernel.org>; Wed, 11 Jun 2025 07:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749652709; x=1750257509; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A6j0biEtB99I7SzduC4IGOhw62CXpo3VTbiHBYid9pA=;
        b=mdyooSaX8EQqwZEeP4sK6z7zh1yPOkRUyFkeCUoogAu2J7PdCJCWSSNuSncZw4dGbU
         uG6haCYAwAp/kAM/W/fhQsY7C76i+wWmllzi/L+CIzY8YzNxwUa2N363U6DV7kurm9Uf
         xsAKW6GKwJJ2ADFZsA56n8ssIqubCxGm5cJuCLiE5TEm1y6o+DfcGDdibmje0WFXvuh5
         iVyLRNrgMZ8mm3f2GtlEj5jEw/+342T8ifhesOKHzVu44fOGgUfUAAFXZLwZERtZTgOW
         N2zF1BbVnGwKup7FsBqW1KMdhUjR8c7yMMka1K6z+ObNH+Ke5H2/GSN5P7MJXV9oilNh
         ZQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749652709; x=1750257509;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A6j0biEtB99I7SzduC4IGOhw62CXpo3VTbiHBYid9pA=;
        b=YbsRhLE2kT74m2kQQ008xOxxchD8g4worfd9HQpv3wtjS25ji8WwVyXUV0pN+3qbeM
         B1tQ0NrsX2rhuQ0Q0jiFYLsNJKSwtgrb0II/Bpp/lfrftu0UxxZu6i6SSCr+JRzVRShY
         TGtqQhLikJbGz0yNWqOlClD9b0jExmB4uc3I7HMQsV6hmfNsG/tVWHzvRbVz1UUJ9Zg1
         MkUIH+p3x9oMqCxbsDRshVxMOg2z3IH5fPR2zS1TzrXtssB4X2oivrYc2YYzhjeGzcSq
         mzimy1XHKr3/b8Db2DUlmNWEf5gNWBYMsI/6NBHi1Z6jcAseZrJiJwb8TV+9pZ26Nxrq
         mYsw==
X-Forwarded-Encrypted: i=1; AJvYcCXYvHQ0ANDLrvVkHEo/jH0+ehoWZuwJgI7Pavuj6XWtimR2hzAkRdNN5/DYbWN1nAa9arX927WSwZ989d0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9NnrRet0rcH15xEXaQVfHIdkrutcB+DHLOhM4ncCrYepDXs68
	c3OH9ZRELHNwxH0BeXCeEMD3t0c2AkaHUxdHpqMrd+YRFjvk7Pgo0qWhkszMxnIE1aqb+MD6JNe
	EyzNx
X-Gm-Gg: ASbGncv57VJhANHh0M8P8/eBYJl1hWo3kHUja2rPtliABoRkjnfznRQ/e04hqV7aT/n
	BUfZQOCk4l1qTfvJOaZcB9Cnf8wXPT9vPaFBkrB2qjioUd06H/ymAomtCJcPIWM6S0OpMho3UTe
	6b84At6l8xWLHtsc3H8CQMgCN/ob0AWYGXbEfH5BpS4JvH/StDzjHIMqL138Tid/oWHQ3PCldFa
	Yav0CCiM6Lj2HRsnwHrg0OyTpKaFyUdk7tnlMhu6YinL2fh9L3ndkZEWhoNomcPf+HvHVd7KHYf
	+PLv7MghOiR5phpRW/+RahczY6DJFB49mGLMRHOS7gkh4WguiDAsPJVOKvNuHweGZE17sAFZaZi
	QDa1HOmsY+GBipTTBLoXw1m8r
X-Google-Smtp-Source: AGHT+IGk1TUfTSRf2WwMN0HBizHNyVuFyGNFi8F+xAN2diNmYy6gFLATJcxMHO+hOBgL1bjNmqSPPg==
X-Received: by 2002:ac8:6904:0:b0:4a3:d015:38ae with SMTP id d75a77b69052e-4a714bc0ca3mr52426861cf.23.1749652698874;
        Wed, 11 Jun 2025 07:38:18 -0700 (PDT)
Received: from xanadu (modemcable179.17-162-184.mc.videotron.ca. [184.162.17.179])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a61985443asm90603141cf.46.2025.06.11.07.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 07:38:18 -0700 (PDT)
Date: Wed, 11 Jun 2025 10:38:17 -0400 (EDT)
From: Nicolas Pitre <npitre@baylibre.com>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/33] tty: vt: use sane types for userspace API
In-Reply-To: <20250611100319.186924-7-jirislaby@kernel.org>
Message-ID: <7pqnq81s-07on-4pr3-q561-29516o9o3457@onlyvoer.pbz>
References: <20250611100319.186924-1-jirislaby@kernel.org> <20250611100319.186924-7-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 11 Jun 2025, Jiri Slaby (SUSE) wrote:

> As discussed earlier (see the Link below), use the preferred ioctl types
> in vt.h (__u8, __u16, ...).
> 
> These types are already used for the new VT_GETCONSIZECSRPOS.
> Therefore, the necessary includes are already present. Since now, the
> types are used for every structure defined in the header now.
> 
> Note the kernel is built with -funsigned-char, therefore 'char' becomes
> '__u8' in here.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Link: https://lore.kernel.org/all/p7p83sq1-4ro2-o924-s9o2-30spr74n076o@syhkavp.arg/

Reviewed-by: Nicolas Pitre <npitre@baylibre.com>

> ---
>  include/uapi/linux/vt.h | 44 ++++++++++++++++++++---------------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/include/uapi/linux/vt.h b/include/uapi/linux/vt.h
> index e5b0c492aa18..714483d68c69 100644
> --- a/include/uapi/linux/vt.h
> +++ b/include/uapi/linux/vt.h
> @@ -19,11 +19,11 @@
>  #define VT_OPENQRY	0x5600	/* find available vt */
>  
>  struct vt_mode {
> -	char mode;		/* vt mode */
> -	char waitv;		/* if set, hang on writes if not active */
> -	short relsig;		/* signal to raise on release req */
> -	short acqsig;		/* signal to raise on acquisition */
> -	short frsig;		/* unused (set to 0) */
> +	__u8 mode;		/* vt mode */
> +	__u8 waitv;		/* if set, hang on writes if not active */
> +	__s16 relsig;		/* signal to raise on release req */
> +	__s16 acqsig;		/* signal to raise on acquisition */
> +	__s16 frsig;		/* unused (set to 0) */
>  };
>  #define VT_GETMODE	0x5601	/* get mode of active vt */
>  #define VT_SETMODE	0x5602	/* set mode of active vt */
> @@ -32,9 +32,9 @@ struct vt_mode {
>  #define		VT_ACKACQ	0x02	/* acknowledge switch */
>  
>  struct vt_stat {
> -	unsigned short v_active;	/* active vt */
> -	unsigned short v_signal;	/* signal to send */
> -	unsigned short v_state;		/* vt bitmask */
> +	__u16 v_active;	/* active vt */
> +	__u16 v_signal;	/* signal to send */
> +	__u16 v_state;		/* vt bitmask */
>  };
>  #define VT_GETSTATE	0x5603	/* get global vt state info */
>  #define VT_SENDSIG	0x5604	/* signal to send to bitmask of vts */
> @@ -46,19 +46,19 @@ struct vt_stat {
>  #define VT_DISALLOCATE	0x5608  /* free memory associated to vt */
>  
>  struct vt_sizes {
> -	unsigned short v_rows;		/* number of rows */
> -	unsigned short v_cols;		/* number of columns */
> -	unsigned short v_scrollsize;	/* number of lines of scrollback */
> +	__u16 v_rows;		/* number of rows */
> +	__u16 v_cols;		/* number of columns */
> +	__u16 v_scrollsize;	/* number of lines of scrollback */
>  };
>  #define VT_RESIZE	0x5609	/* set kernel's idea of screensize */
>  
>  struct vt_consize {
> -	unsigned short v_rows;	/* number of rows */
> -	unsigned short v_cols;	/* number of columns */
> -	unsigned short v_vlin;	/* number of pixel rows on screen */
> -	unsigned short v_clin;	/* number of pixel rows per character */
> -	unsigned short v_vcol;	/* number of pixel columns on screen */
> -	unsigned short v_ccol;	/* number of pixel columns per character */
> +	__u16 v_rows;	/* number of rows */
> +	__u16 v_cols;	/* number of columns */
> +	__u16 v_vlin;	/* number of pixel rows on screen */
> +	__u16 v_clin;	/* number of pixel rows per character */
> +	__u16 v_vcol;	/* number of pixel columns on screen */
> +	__u16 v_ccol;	/* number of pixel columns per character */
>  };
>  #define VT_RESIZEX      0x560A  /* set kernel's idea of screensize + more */
>  #define VT_LOCKSWITCH   0x560B  /* disallow vt switching */
> @@ -66,21 +66,21 @@ struct vt_consize {
>  #define VT_GETHIFONTMASK 0x560D  /* return hi font mask */
>  
>  struct vt_event {
> -	unsigned int event;
> +	__u32 event;
>  #define VT_EVENT_SWITCH		0x0001	/* Console switch */
>  #define VT_EVENT_BLANK		0x0002	/* Screen blank */
>  #define VT_EVENT_UNBLANK	0x0004	/* Screen unblank */
>  #define VT_EVENT_RESIZE		0x0008	/* Resize display */
>  #define VT_MAX_EVENT		0x000F
> -	unsigned int oldev;		/* Old console */
> -	unsigned int newev;		/* New console (if changing) */
> -	unsigned int pad[4];		/* Padding for expansion */
> +	__u32 oldev;		/* Old console */
> +	__u32 newev;		/* New console (if changing) */
> +	__u32 pad[4];		/* Padding for expansion */
>  };
>  
>  #define VT_WAITEVENT	0x560E	/* Wait for an event */
>  
>  struct vt_setactivate {
> -	unsigned int console;
> +	__u32 console;
>  	struct vt_mode mode;
>  };
>  
> -- 
> 2.49.0
> 
> 
