Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF882F3635
	for <linux-serial@vger.kernel.org>; Mon, 16 Jun 2025 13:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750080814; cv=none; b=t/3pBO3BH7cMQRp0qZMsNc090FGWjoViSFj7krDAYUX3UIulOIwZV+OZI14YjsI/RtgXQVLqbX287i6dSAqpnLOF2kTwe0K2Npn6N04xle9Xh5KtNdkW/TyCNlBy7EJFXizcMAFOA4Y+DbuFZSfVRVx0bjTvhljyIUV2EaEpQo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750080814; c=relaxed/simple;
	bh=/PmblSL9BUeWLs9QcuEhZwOxi3hMLjCTpeJw/Yoam94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOjcXhcV85RgI+ZcGq2PPXkra1z172kgCmxyC9HB+MqGA70u2U8OYNgqogWr/1zxcxUA7DP5B1pbmTmFn6sNz+Uda9WVzqntzbv1tviWX+rZapDrb9bmzXM7BNDPklJaGCYFPuId90XKvc+4enA3KB1mmYfVuhEj54nZA2niRh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OvEPh/dN; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OvEPh/dN"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a575a988f9so1360623f8f.0
        for <linux-serial@vger.kernel.org>; Mon, 16 Jun 2025 06:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750080810; x=1750685610; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mDsjdTiosngDCcbjk569uHEPxRmT2Rin/eFUrpVF9Nc=;
        b=OvEPh/dNF/Duj1GBom7xu+Bc5AScZLfHzd+IAqYwPPzePNv2OmZNddSGnTNjvczK1N
         KMDWP/VmCeZK0TYMFPNeXfeZbGtPFZD7AK7PzUpIS74Gc/nFrD6vNSv8mkx47NBZqH3W
         h+O2qb3TXKvuUTApSgRYdzUClhTo6YmcCeohMHjsNuMNqPbiJJFavGcdYknnUjuygde1
         k4lou+pRmEucC185ydKehRRWPr0vKTMVOdY1Jfm0Y0ICyYkQqGURDuaQ69SWHB+wwiUk
         5194Cg9C5OUrf3bGhnRylrH5NX9JA6E6CVZdP2pJjJFkOs+TlEkMvi5iBpFMMcpdXrOk
         vKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750080810; x=1750685610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDsjdTiosngDCcbjk569uHEPxRmT2Rin/eFUrpVF9Nc=;
        b=Db8jh8z9+1dHOUKepFmQOHpBzvahtKVsQMWhNKNFC7xHNLXYXllfqUT6/2s3g+m5FA
         ifmKPsfdiDwRQcsnmWtaS//vXrgRsaxqrQluN52UU0+b/0E5Sh1c03Y0/39vmRQEwz18
         zB/gf5ACOfU2hgmy8hBfxi1o/MWeUaaAiACSlZCKp0YgjSxWwsMb+KPjrblcaBDev42I
         HnZg1h9HJGUS7cDTxD9vmBg5TUbviMd5leyKAwAEnyeH6TnLmpwJlhG460rIzGqQTiWb
         Y/2tFIb4tUr4n8TDINglfykeeBFxVcuy9WTkZK2UP5r7tQ0ajvJiui1/fxIDsdA4GQYc
         O1Aw==
X-Forwarded-Encrypted: i=1; AJvYcCWI+FaVaDsIK3NCiVeEq1sboOUfXPBBvVq3nQXYv2wOFo++ptVv+3Q9RVN2CD/zAQT6EQBIHqCdjCxwB/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOYZpvqIvC0CwXDr8NAvg27pxIZaDIyEecd005XDAh8QUwMq3w
	JsitlBX06FZsZYOZBtbKIKDBHuUTLQFdmqv/WMsrxUlVEVBTvVyYLUMFzCTLXDEyN0k=
X-Gm-Gg: ASbGncv9G8UeiEK3s3tjbmPcfbjBd0owhAw7HbalL5f3NmsuPnvTO+FSSWINgW97p+i
	AjB0+hfoUn8uNaDs7TGtlv/J1L2U2dO3fuHbPOACIKsmqi1RL4TUAMS9Pd4Z/ziB5ylKgS6Ddlq
	7DYhZ3ZJK5y8HYdSWYCRS7jeaZNSSn/kL1jZC4APcA7zGtMruUehkCkODmtNMeTLuOaxComJUc2
	AWMNivFM8fcV/50975ZgKylktNWWOG278A3olalv3HDSirxen1ZDfAxi2n5fa7alDndcLj3dcVi
	kbnt4HUE8qvBvGuch2rA4vQHa2zm7xNFFfr+G0OEfVTacu2Dt4YxSfFVrjboGDci
X-Google-Smtp-Source: AGHT+IHsMKMEFnK4iRSKN4yA2G25+VoXuC33JoKTL84hU+3purxVVSbR+gePOjO6tpOk2JJiHzT3Fg==
X-Received: by 2002:a5d:5887:0:b0:3a5:2dae:970c with SMTP id ffacd0b85a97d-3a572e82154mr7975991f8f.37.1750080810126;
        Mon, 16 Jun 2025 06:33:30 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de77605sm60637745ad.105.2025.06.16.06.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 06:33:29 -0700 (PDT)
Date: Mon, 16 Jun 2025 15:33:13 +0200
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
Subject: Re: [PATCH 5/7] arch: um: kmsg_dump: Don't check for CON_ENABLED
Message-ID: <aFAdGas9yGB4zhqc@pathway.suse.cz>
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
 <20250606-printk-cleanup-part2-v1-5-f427c743dda0@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606-printk-cleanup-part2-v1-5-f427c743dda0@suse.com>

On Fri 2025-06-06 23:53:47, Marcos Paulo de Souza wrote:
> All consoles found on for_each_console are registered, meaning that all of
> them are CON_ENABLED. The code tries to find an active console, so check if the
> console is not suspended instead.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  arch/um/kernel/kmsg_dump.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
> index 4190211752726593dd2847f66efd9d3a61cea982..f3025b2a813453f479d720618c630bee135d4e08 100644
> --- a/arch/um/kernel/kmsg_dump.c
> +++ b/arch/um/kernel/kmsg_dump.c
> @@ -31,7 +31,7 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
>  		 * expected to output the crash information.
>  		 */
>  		if (strcmp(con->name, "ttynull") != 0 &&
> -		    (console_srcu_read_flags(con) & CON_ENABLED)) {
> +		    (console_srcu_read_flags(con) & CON_SUSPENDED) == 0) {
>  			break;

I think that we should actually replace the check of the
CON_ENABLE/CON_SUSPENDED flag with

		is_console_usable(con, console_srcu_read_flags(con), true)

And it should be done at the beginning of the patchset before
changing the semantic of the flags.

Motivation:

There is the following comment at the beginning of the function:

	/*
	 * If no consoles are available to output crash information, dump
	 * the kmsg buffer to stdout.
	 */

The if-condition checks for:

  + "ttynull" because this special console does not show any messages
    by definition

  + disabled/suspended consoles; note that this patchset is replacing
    CON_ENABLED with CON_SUSPENDED flag because it the state is
    changed during suspend.

But it should check also for:

  + whether the console is NBCON_console and does not have con->write_atomic
    because such a console would not be able to show the messages
    in panic().

And it should also check the global "consoles_suspended" flag. Because
consoles won't show anything when it is set.

And all these is already done by "is_console_usable()" except for
the check of "ttynull" which is very special.

How does the sound, please?

Best Regards,
Petr

>  		}
>  	}
> 
> -- 
> 2.49.0
