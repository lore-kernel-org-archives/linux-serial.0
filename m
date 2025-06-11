Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0C227AC54
	for <linux-serial@vger.kernel.org>; Wed, 11 Jun 2025 14:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749652984; cv=none; b=G07ueMfh7Cu8WT05sAXKiZLQNwOSeocouxe7QRcz24YCMPgSo3VYiBT2onn+zW7jx5rgkdLKTJ/RbZvg1Wxs366NLF/YQkiMZcLP/KS1cQgwnnygnNMriCitjp9GawHtD05NGPs/TAibSVcyVFhMeIYLy8NHtahWD5kzRkU06rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749652984; c=relaxed/simple;
	bh=cclPtbM4URW+eHiaPTS+SHyrinx7Ma5PBGOytirKWy8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hTxBg6Mya70yA3KuQCdoVLPhDgBkrgs99aCOJ/D2sIOWZ/hBylMrKWUv9fAFOxMg9S/i0jMF3LxkOtl6gP3fzNCC+iQte6VuSBTZClDU24asw6Q2tIxsImXg/+vEIZKE7THg6wauoJhOH1aVW/pi+uGm6HpELFRzhk5SN4REqAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jol07FQT; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jol07FQT"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-8723a232750so589784539f.1
        for <linux-serial@vger.kernel.org>; Wed, 11 Jun 2025 07:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749652981; x=1750257781; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5UqPIqFartaPblQPlcuUyc+gxPJ8IWERL5l+XGvc8xk=;
        b=jol07FQTDs4ygUJ5p/drnb1EO2WFd3tK65xZ6JlkTL9hZI/NMie3nqJV6/VuN1XZGX
         Jb7lEEldumQ9QtSnCIPsxFLF5Dcbzrmj95ffHXcVWrVkGO4d7pXpMo7uerLk6rwBliOk
         jzLsCwqVs5KhOhuWQru+T8ivqllE74V+UGjKEk3UeDYJrDq1566x1C3YP1I6vSfSdztX
         64GkQzmdlvg2tn4ii7JopVy2xK9WVsadIeV28o1Jgb1ABYeN7kl+u9JUX05MNDh4R2PZ
         bPnnf33XjfCRbRkUZNgsAEBxqtPxvLB3beEbu0jGCRpxCh33dQM3ChVrevZvlSDhIqgo
         1LuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749652981; x=1750257781;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5UqPIqFartaPblQPlcuUyc+gxPJ8IWERL5l+XGvc8xk=;
        b=S+goLeqoLESqYvGMQOr28g26XEcxfFjQGMbImc+yDKkxPDZe2jUZ4aG0QzIK/Ipocv
         XSQAScyZSbM/R5RkqnLmJmXCbIJhCL1anE3d8mhXWhUljqKjSV10yf8FpdOBAnZhOFJ1
         Fvt0MCq6S+89ediCylWKkGA+j8hl0DPQkoqrgPvDYuVEEYLwYSdfnYxEuNmLIdqoCbZI
         /q8fsXfzke6fkb3Q4PXub06oXJ6iOPEs9XNXrFsZ6+nUs03ELgajcLTLpzNNNSHbruPb
         e1TuBEL7N+gTBgdx4e3HMN7c7E7y4A2r8F+RO06m4U4lLK5c79Xn4XFzm87T2Ltdn7wP
         Y2oA==
X-Forwarded-Encrypted: i=1; AJvYcCUyE0Mssh1TYsXMq7l5Fwnc8+FH7ej8WNbgUnu6bDRixrSxUsYXYX5liFnsct8/T9GQyIQgrPa2UgV8CPA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3MdOLnF9BOAzT4LIuH8XZ2kAqFDSnkMdTNoKRzs6ORwlQLdY9
	WzFPc7BrHXQoNsTPL5hhPLL2rLijBqODlGgxeJvCJTcP/yqXUc6pWgiCh09/RTnASsDEZ1nMU2+
	vdw7O
X-Gm-Gg: ASbGncuKKaegDn4oPnMw08y5rqnaHX4hhv1W0/0gU757F2NsINM2fVe0LVxu0aM9Ylw
	G8T5GNNLx2fJmGE1LEplFeeogXyeQuNbrmzYRXumVa0/L2oHKrO5AVjBdeBer2bfMLEYykDqvdK
	VikIy6WVLnfzRmoPFEMWX8yqvae1U7EadR65I/EsZV06Ty2Rjk2i+drbLXfqlmGwZaze6argFfX
	nYOATcYKrrAAjuPtOvImN9ujiIDVwcIF5KK8rBtNgM4/JLgwGRC+4IcbqqYVn9NoNUFw68MQz2N
	gqZGEWyvIAZNPJUYuc/kUgiENg/3N1RefSSRe6cZWU3tq1wNVccDCymRfPg6vgJJcTSeB3S0CRL
	sJRWtjBAgQ0mORv5liCqL+zb6IVqIpkSDg4g=
X-Google-Smtp-Source: AGHT+IFC7MoxQ9CiG2v6hQKNS9M+a23H++31zfrbnKZkH0xG2tyrkZnEOyKLbgpIwmujkpqmsiL1Ww==
X-Received: by 2002:a05:6214:300a:b0:6f4:ca4f:43f8 with SMTP id 6a1803df08f44-6fb2d0ce77amr44105966d6.6.1749652970490;
        Wed, 11 Jun 2025 07:42:50 -0700 (PDT)
Received: from xanadu (modemcable179.17-162-184.mc.videotron.ca. [184.162.17.179])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb09b1ce86sm82940086d6.61.2025.06.11.07.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 07:42:49 -0700 (PDT)
Date: Wed, 11 Jun 2025 10:42:48 -0400 (EDT)
From: Nicolas Pitre <npitre@baylibre.com>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/33] tty: vt: use _IO() to define ioctl numbers
In-Reply-To: <20250611100319.186924-8-jirislaby@kernel.org>
Message-ID: <s30q2616-q5ss-64oo-92r0-956nss9p244o@onlyvoer.pbz>
References: <20250611100319.186924-1-jirislaby@kernel.org> <20250611100319.186924-8-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 11 Jun 2025, Jiri Slaby (SUSE) wrote:

> _IO*() is the proper way of defining ioctl numbers. All these vt numbers
> were synthetically built up the same way the _IO() macro does.
> 
> So instead of implicit hex numbers, use _IO() properly.
> 
> To not change the pre-existing numbers, use only _IO() (and not _IOR()
> or _IOW()). The latter would change the numbers indeed.
> 
> Objdump of vt_ioctl.o reveals no difference with this patch.
> 
> Again, VT_GETCONSIZECSRPOS already uses _IOR(), so everything is paved
> for this patch.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Nicolas Pitre <nico@fluxnic.net>

Reviewed-by: Nicolas Pitre <npitre@baylibre.com>

> ---
>  include/uapi/linux/vt.h | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/include/uapi/linux/vt.h b/include/uapi/linux/vt.h
> index 714483d68c69..b60fcdfb2746 100644
> --- a/include/uapi/linux/vt.h
> +++ b/include/uapi/linux/vt.h
> @@ -14,9 +14,9 @@
>  		/* Note: the ioctl VT_GETSTATE does not work for
>  		   consoles 16 and higher (since it returns a short) */
>  
> -/* 0x56 is 'V', to avoid collision with termios and kd */
> +/* 'V' to avoid collision with termios and kd */
>  
> -#define VT_OPENQRY	0x5600	/* find available vt */
> +#define VT_OPENQRY		_IO('V', 0x00)	/* find available vt */
>  
>  struct vt_mode {
>  	__u8 mode;		/* vt mode */
> @@ -25,8 +25,8 @@ struct vt_mode {
>  	__s16 acqsig;		/* signal to raise on acquisition */
>  	__s16 frsig;		/* unused (set to 0) */
>  };
> -#define VT_GETMODE	0x5601	/* get mode of active vt */
> -#define VT_SETMODE	0x5602	/* set mode of active vt */
> +#define VT_GETMODE		_IO('V', 0x01)	/* get mode of active vt */
> +#define VT_SETMODE		_IO('V', 0x02)	/* set mode of active vt */
>  #define		VT_AUTO		0x00	/* auto vt switching */
>  #define		VT_PROCESS	0x01	/* process controls switching */
>  #define		VT_ACKACQ	0x02	/* acknowledge switch */
> @@ -36,21 +36,21 @@ struct vt_stat {
>  	__u16 v_signal;	/* signal to send */
>  	__u16 v_state;		/* vt bitmask */
>  };
> -#define VT_GETSTATE	0x5603	/* get global vt state info */
> -#define VT_SENDSIG	0x5604	/* signal to send to bitmask of vts */
> +#define VT_GETSTATE		_IO('V', 0x03)	/* get global vt state info */
> +#define VT_SENDSIG		_IO('V', 0x04)	/* signal to send to bitmask of vts */
>  
> -#define VT_RELDISP	0x5605	/* release display */
> +#define VT_RELDISP		_IO('V', 0x05)	/* release display */
>  
> -#define VT_ACTIVATE	0x5606	/* make vt active */
> -#define VT_WAITACTIVE	0x5607	/* wait for vt active */
> -#define VT_DISALLOCATE	0x5608  /* free memory associated to vt */
> +#define VT_ACTIVATE		_IO('V', 0x06)	/* make vt active */
> +#define VT_WAITACTIVE		_IO('V', 0x07)	/* wait for vt active */
> +#define VT_DISALLOCATE		_IO('V', 0x08)  /* free memory associated to vt */
>  
>  struct vt_sizes {
>  	__u16 v_rows;		/* number of rows */
>  	__u16 v_cols;		/* number of columns */
>  	__u16 v_scrollsize;	/* number of lines of scrollback */
>  };
> -#define VT_RESIZE	0x5609	/* set kernel's idea of screensize */
> +#define VT_RESIZE		_IO('V', 0x09)	/* set kernel's idea of screensize */
>  
>  struct vt_consize {
>  	__u16 v_rows;	/* number of rows */
> @@ -60,10 +60,10 @@ struct vt_consize {
>  	__u16 v_vcol;	/* number of pixel columns on screen */
>  	__u16 v_ccol;	/* number of pixel columns per character */
>  };
> -#define VT_RESIZEX      0x560A  /* set kernel's idea of screensize + more */
> -#define VT_LOCKSWITCH   0x560B  /* disallow vt switching */
> -#define VT_UNLOCKSWITCH 0x560C  /* allow vt switching */
> -#define VT_GETHIFONTMASK 0x560D  /* return hi font mask */
> +#define VT_RESIZEX		_IO('V', 0x0A)  /* set kernel's idea of screensize + more */
> +#define VT_LOCKSWITCH		_IO('V', 0x0B)  /* disallow vt switching */
> +#define VT_UNLOCKSWITCH		_IO('V', 0x0C)  /* allow vt switching */
> +#define VT_GETHIFONTMASK	_IO('V', 0x0D)  /* return hi font mask */
>  
>  struct vt_event {
>  	__u32 event;
> @@ -77,14 +77,14 @@ struct vt_event {
>  	__u32 pad[4];		/* Padding for expansion */
>  };
>  
> -#define VT_WAITEVENT	0x560E	/* Wait for an event */
> +#define VT_WAITEVENT		_IO('V', 0x0E)	/* Wait for an event */
>  
>  struct vt_setactivate {
>  	__u32 console;
>  	struct vt_mode mode;
>  };
>  
> -#define VT_SETACTIVATE	0x560F	/* Activate and set the mode of a console */
> +#define VT_SETACTIVATE		_IO('V', 0x0F)	/* Activate and set the mode of a console */
>  
>  /* get console size and cursor position */
>  struct vt_consizecsrpos {
> -- 
> 2.49.0
> 
> 
