Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547A022DF8D;
	Thu,  6 Feb 2025 14:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738852065; cv=none; b=PcF0QabjWnWOruL8JOrg5cUIKsmlSPmZKLJV/4EwUZiX6QVZzbm1b6EahfpM+YZWJGdNdVb+DfIxhxOOFwuQueSEFqGeQthTUwjP2ZWGBmIhdaWKmZU8Ci/XE1YA8LQsazyDKsPT8Jsfa6lQDUSOez17tvEJI4/34KZZ2tylGMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738852065; c=relaxed/simple;
	bh=HYdtNQk/zVRnrQ97mZS+MqRUinrWY0HqfCUY6ahYIqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzyine7P+8eFkHWnME+9pHIZtaOp5s4NFYy1h9h0WLBGvaVONNdXX1UA2bDo44rT/sONhRu6fPECFq5P2BWRKfZZ0dVasbJnGICNzYk6Z1pqXbofOuhsOGjWQ9QKe2CzCSeKmAfEefbd9ohEzhOvtqDOV76nOHGofJAGKClXv/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ReB8p5T2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ReB8p5T2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47010C4CEDD;
	Thu,  6 Feb 2025 14:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738852062;
	bh=HYdtNQk/zVRnrQ97mZS+MqRUinrWY0HqfCUY6ahYIqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ReB8p5T2AGJ5xFHrXPlC61Odas+Kb8KuG0naRprAb9DhteFaI02uBfAhFXnR3FsON
	 xtGY/ZZRt06f4aZ3KuVdl5WSe+2brVWBxk9r+sU0dUR0z5Wmy94lRt4EaBLcLzY9WJ
	 sd1pxtOzXyGs7HT26RAhggIkuXfw7PtiSPrY8oqU=
Date: Thu, 6 Feb 2025 05:40:55 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3][next] tty: tty_buffer: Avoid hundreds of
 -Wflex-array-member-not-at-end warnings
Message-ID: <2025020633-irritate-boogieman-4c35@gregkh>
References: <Z6QvAZxiQusdaDkH@kspp>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6QvAZxiQusdaDkH@kspp>

On Thu, Feb 06, 2025 at 02:09:45PM +1030, Gustavo A. R. Silva wrote:
> diff --git a/include/linux/tty_buffer.h b/include/linux/tty_buffer.h
> index 31125e3be3c5..80a9d7832c97 100644
> --- a/include/linux/tty_buffer.h
> +++ b/include/linux/tty_buffer.h
> @@ -7,7 +7,7 @@
>  #include <linux/mutex.h>
>  #include <linux/workqueue.h>
>  
> -struct tty_buffer {
> +struct tty_buffer_hdr {
>  	union {
>  		struct tty_buffer *next;
>  		struct llist_node free;
> @@ -15,9 +15,13 @@ struct tty_buffer {
>  	unsigned int used;
>  	unsigned int size;
>  	unsigned int commit;
> -	unsigned int lookahead;		/* Lazy update on recv, can become less than "read" */
> +	unsigned int lookahead; /* Lazy update on recv, can become less than "read" */

Coding style change?

