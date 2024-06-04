Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E2C143747;
	Tue,  4 Jun 2024 12:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717502417; cv=none; b=tzyoHXa+xLjRjj4piWN5OlMVKR53371idK9xitPTRpoudzKS8A6t7u+uvX9JnjeeqXgrZ0g1lKTijZj4p250ki3THOJkNFboJaqTVXFWS+7Jl8mndu6gs7UTLJ3DLBfvPdOHZayV3T6b8l5naOv6VfA5R3do3kleiiXKdeP+9QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717502417; c=relaxed/simple;
	bh=eqE7x5Q4KIK4ZhrIEHkVVYrLWJDlF/DUiMDehriwCTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSBMvDpPMsN7Vj8+goJ6cN5UQEKaT/uDEoQbipvelANR+3j4JKVxkI2V0CdwbfZi43Z4XS3LIjraH+jA/8RQyEhvMWkpYfPMmVwc4QSSc1OCJTLf3HUwdzRlGSNwq7eoGkRRcO5odRzauL6iJRb7fshSgwfCxYEby9ZgHQ6SGp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ieiq1XQJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ieiq1XQJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A05A7C4AF07;
	Tue,  4 Jun 2024 12:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717502416;
	bh=eqE7x5Q4KIK4ZhrIEHkVVYrLWJDlF/DUiMDehriwCTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ieiq1XQJOJfjLdRI5jlR239D8NJMMLc+FoMN/QnRYY5BTH1k6PEbKVEGGn+DZu0Rz
	 QxqpjwV3/+sWUXbyWUuYXZ6UovaRiT6ct111vDS2xjmkZAfQG5QYHITGTUog2V3b23
	 FROn9Jloy6XkO9agGA6LJ0BrVoGncQVewA8nxEBA=
Date: Tue, 4 Jun 2024 13:48:01 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH printk v2 15/18] tty: sysfs: Add nbcon support for
 'active'
Message-ID: <2024060454-tapered-tile-c22f@gregkh>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
 <20240603232453.33992-16-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603232453.33992-16-john.ogness@linutronix.de>

On Tue, Jun 04, 2024 at 01:30:50AM +0206, John Ogness wrote:
> Allow the 'active' attribute to list nbcon consoles.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  drivers/tty/tty_io.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
