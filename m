Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCEB18A921;
	Thu, 31 Jul 2025 14:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753973437; cv=none; b=mbtVcVqhqhIPfYtaOY04UBZsA5aAgS26+aCUUgDwi1MgC5Jk62e4azE9CmpUJ/hxIyXyMXyAivk0Lvp8Q5bcnctF0vVXxyqmu/4v569Gk3/gq6p5I9WTrQiTdsLLxX4FjYbkPUzRaCk/v+UCesgVYG0vhHTdSUdqIZYCznhiQYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753973437; c=relaxed/simple;
	bh=5nJwEKl86KfPhEN1fVi/ls4u4h/LG0UACScgfWSWJ2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vfaji+G+1dii5DnJOXCVT6qHA1RC2nvE3bA7Nmq5+slhUso0u8lE4QqMUhehJfWmlIBHcH80/87A4AoIgC0CzYG1whEzXe+sMh2PMOty1Rj0h4lf7KLamP8+AWMCYlnX+o4Oq14uQvnC4lKHqWwVjrijw6LDM4sAhZjvlRcedlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4btBTZ5DWGz9v2F;
	Thu, 31 Jul 2025 16:36:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WZlP0oQyI-4P; Thu, 31 Jul 2025 16:36:02 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4btBTT42bZz9tt4;
	Thu, 31 Jul 2025 16:35:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 85BCB8B76E;
	Thu, 31 Jul 2025 16:35:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id V6oOUUz4ZD7m; Thu, 31 Jul 2025 16:35:57 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 19FCF8B763;
	Thu, 31 Jul 2025 16:35:57 +0200 (CEST)
Message-ID: <97ec2636-915a-498c-903b-d66957420d21@csgroup.eu>
Date: Thu, 31 Jul 2025 16:35:56 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/33] tty: vt: use _IO() to define ioctl numbers
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, gregkh@linuxfoundation.org,
 Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nicolas Pitre <nico@fluxnic.net>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <20250611100319.186924-1-jirislaby@kernel.org>
 <20250611100319.186924-8-jirislaby@kernel.org>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20250611100319.186924-8-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jiri,

Le 11/06/2025 à 12:02, Jiri Slaby (SUSE) a écrit :
> _IO*() is the proper way of defining ioctl numbers. All these vt numbers
> were synthetically built up the same way the _IO() macro does.
> 
> So instead of implicit hex numbers, use _IO() properly.
> 
> To not change the pre-existing numbers, use only _IO() (and not _IOR()
> or _IOW()). The latter would change the numbers indeed.

On powerpc your assumption is wrong, because _IOC_NONE is not 0:

$ git grep _IOC_NONE arch/powerpc/
arch/powerpc/include/uapi/asm/ioctl.h:#define _IOC_NONE 1U

Therefore the value changes even with _IO(), leading to failure of Xorg 
as reported by Christian.

Christophe

> 
> Objdump of vt_ioctl.o reveals no difference with this patch.
> 
> Again, VT_GETCONSIZECSRPOS already uses _IOR(), so everything is paved
> for this patch.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Nicolas Pitre <nico@fluxnic.net>
> ---
>   include/uapi/linux/vt.h | 34 +++++++++++++++++-----------------
>   1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/include/uapi/linux/vt.h b/include/uapi/linux/vt.h
> index 714483d68c69..b60fcdfb2746 100644
> --- a/include/uapi/linux/vt.h
> +++ b/include/uapi/linux/vt.h
> @@ -14,9 +14,9 @@
>   		/* Note: the ioctl VT_GETSTATE does not work for
>   		   consoles 16 and higher (since it returns a short) */
>   
> -/* 0x56 is 'V', to avoid collision with termios and kd */
> +/* 'V' to avoid collision with termios and kd */
>   
> -#define VT_OPENQRY	0x5600	/* find available vt */
> +#define VT_OPENQRY		_IO('V', 0x00)	/* find available vt */
>   
>   struct vt_mode {
>   	__u8 mode;		/* vt mode */
> @@ -25,8 +25,8 @@ struct vt_mode {
>   	__s16 acqsig;		/* signal to raise on acquisition */
>   	__s16 frsig;		/* unused (set to 0) */
>   };
> -#define VT_GETMODE	0x5601	/* get mode of active vt */
> -#define VT_SETMODE	0x5602	/* set mode of active vt */
> +#define VT_GETMODE		_IO('V', 0x01)	/* get mode of active vt */
> +#define VT_SETMODE		_IO('V', 0x02)	/* set mode of active vt */
>   #define		VT_AUTO		0x00	/* auto vt switching */
>   #define		VT_PROCESS	0x01	/* process controls switching */
>   #define		VT_ACKACQ	0x02	/* acknowledge switch */
> @@ -36,21 +36,21 @@ struct vt_stat {
>   	__u16 v_signal;	/* signal to send */
>   	__u16 v_state;		/* vt bitmask */
>   };
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
>   struct vt_sizes {
>   	__u16 v_rows;		/* number of rows */
>   	__u16 v_cols;		/* number of columns */
>   	__u16 v_scrollsize;	/* number of lines of scrollback */
>   };
> -#define VT_RESIZE	0x5609	/* set kernel's idea of screensize */
> +#define VT_RESIZE		_IO('V', 0x09)	/* set kernel's idea of screensize */
>   
>   struct vt_consize {
>   	__u16 v_rows;	/* number of rows */
> @@ -60,10 +60,10 @@ struct vt_consize {
>   	__u16 v_vcol;	/* number of pixel columns on screen */
>   	__u16 v_ccol;	/* number of pixel columns per character */
>   };
> -#define VT_RESIZEX      0x560A  /* set kernel's idea of screensize + more */
> -#define VT_LOCKSWITCH   0x560B  /* disallow vt switching */
> -#define VT_UNLOCKSWITCH 0x560C  /* allow vt switching */
> -#define VT_GETHIFONTMASK 0x560D  /* return hi font mask */
> +#define VT_RESIZEX		_IO('V', 0x0A)  /* set kernel's idea of screensize + more */
> +#define VT_LOCKSWITCH		_IO('V', 0x0B)  /* disallow vt switching */
> +#define VT_UNLOCKSWITCH		_IO('V', 0x0C)  /* allow vt switching */
> +#define VT_GETHIFONTMASK	_IO('V', 0x0D)  /* return hi font mask */
>   
>   struct vt_event {
>   	__u32 event;
> @@ -77,14 +77,14 @@ struct vt_event {
>   	__u32 pad[4];		/* Padding for expansion */
>   };
>   
> -#define VT_WAITEVENT	0x560E	/* Wait for an event */
> +#define VT_WAITEVENT		_IO('V', 0x0E)	/* Wait for an event */
>   
>   struct vt_setactivate {
>   	__u32 console;
>   	struct vt_mode mode;
>   };
>   
> -#define VT_SETACTIVATE	0x560F	/* Activate and set the mode of a console */
> +#define VT_SETACTIVATE		_IO('V', 0x0F)	/* Activate and set the mode of a console */
>   
>   /* get console size and cursor position */
>   struct vt_consizecsrpos {

