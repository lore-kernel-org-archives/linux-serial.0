Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B64C1632D9;
	Wed,  8 Jan 2025 11:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736336434; cv=none; b=sfjLzHO18G9tNq0El20x7DDLY3hqAvLGKgKcUza93p7cWmkBxf6gExk8YOgIy/TG+3CUW+4uJgkGyzxLZNa7G4wocGnwLtu4OtmD8iJ4Hd20vHbWC4BsQZu9VhiJ+0uBzp9JuBULoB/RSAbDNgYGH0DBvVzq+1zy2JUwKajrs7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736336434; c=relaxed/simple;
	bh=bH3Bm7ha58wqkbTHymeisNRVdWPK2PVvkSpKMNIx60g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4BqgkTrPuiH4+t1/h/xeEyMs9dhwaNUT0kRj1jKFyp2nOU58XBX5coN5rSa//Plqbp/RUX04eWN0kGH1hdR/y+QTkzW+5D2EEdSqMR1VjYjwN9HL/mGhtP7zOSWVQ+PDkq8TbBzC9vgyy8UWCt+vws48UVnnBplpcN2GY4XAPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=doDE+CFb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="doDE+CFb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E13C2C4CEDF;
	Wed,  8 Jan 2025 11:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736336433;
	bh=bH3Bm7ha58wqkbTHymeisNRVdWPK2PVvkSpKMNIx60g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=doDE+CFbl0lAX2CPYhSzwYMYr00QNFaz968v7sVrY+tH64y7d1idqfxNnC9r50+yM
	 l55VGzjCXWFlRTV3EJykDrfYme0c2UmrfFJFnPLjlrJUbnHsBlhQEipwp/hXZizuDD
	 2cXFdcYeEZGakZhsjPmv+0CoaYudgUGVikLTn0EHmAy1WzYHyLWgnqeBtK91AdVYHn
	 HP8XDQx8p8ui/hxZO7oXcYzfa+zIHAna/d8AwKmUQjxwAhQUgXwQ89n34/tW8h2ZuW
	 OiqdltFimik7oUjlfqD3EAipP+taPByTKQAVAPHTRrZZUTAfVA1JhqUwjGmAdtPV20
	 vT1NcBIAPj2/w==
Date: Wed, 8 Jan 2025 11:40:28 +0000
From: Daniel Thompson <danielt@kernel.org>
To: Amal Raj T <tjarlama@gmail.com>
Cc: dianders@chromium.org, jason.wessel@windriver.com,
	stephen.s.brennan@oracle.com, amalrajt@meta.com,
	osandov@osandov.com, linux-debuggers@vger.kernel.org,
	linux-serial@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH v2 1/3] kgdb: Add kgdb_mem2ebin function for converting
 memory to binary format
Message-ID: <Z35kLN5mkekkfgql@aspen.lan>
References: <gmail>
 <20241211153955.33518-1-tjarlama@gmail.com>
 <20241211153955.33518-2-tjarlama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241211153955.33518-2-tjarlama@gmail.com>

On Wed, Dec 11, 2024 at 07:39:53AM -0800, Amal Raj T wrote:
> From: Amal Raj T <amalrajt@meta.com>
>
> Add a new function kgdb_mem2ebin that converts memory
> to binary format, escaping special characters
> ('$', '#', and '}').

What about the '*' character?

The gdb docs say "Responses sent by the stub must also escape 0x2a
(ASCII ‘*’), so that it is not interpreted as the start of a run-length
encoded sequence".


> kgdb_mem2ebin function ensures
> that memory data is properly formatted and escaped
> before being sent over the wire. Additionally, this
> function reduces the amount of data exchanged between
> debugger compared to hex.
>
> Signed-off-by: Amal Raj T <amalrajt@meta.com>
> ---
>  include/linux/kgdb.h   |  1 +
>  kernel/debug/gdbstub.c | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> index 76e891ee9e37..fa3cf38a14de 100644
> --- a/include/linux/kgdb.h
> +++ b/include/linux/kgdb.h
> @@ -322,6 +322,7 @@ extern struct kgdb_io *dbg_io_ops;
>
>  extern int kgdb_hex2long(char **ptr, unsigned long *long_val);
>  extern char *kgdb_mem2hex(char *mem, char *buf, int count);
> +extern char *kgdb_mem2ebin(char *mem, char *buf, int count);
>  extern int kgdb_hex2mem(char *buf, char *mem, int count);
>
>  extern int kgdb_isremovedbreak(unsigned long addr);
> diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
> index f625172d4b67..6198d2eb49c4 100644
> --- a/kernel/debug/gdbstub.c
> +++ b/kernel/debug/gdbstub.c
> @@ -257,6 +257,37 @@ char *kgdb_mem2hex(char *mem, char *buf, int count)
>  	return buf;
>  }
>
> +/*
> + * Convert memory to binary format for GDB remote protocol
> + * transmission, escaping special characters ($, #, and }).
> + */

It would be good to include a link to the following in this comment:
https://sourceware.org/gdb/current/onlinedocs/gdb.html/Overview.html#Binary-Data

Doug already mentioned putting buffer size expectations in this comment.
Maybe also mention that the worst case packing is identical to
kgdb_mem2hex() (e.g. 2*count + 1).


Daniel.
