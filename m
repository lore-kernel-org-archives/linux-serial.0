Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D908513A244;
	Thu,  3 Apr 2025 08:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743669991; cv=none; b=Ze5nuIozU5qtTqsqs/1CnbjUL3te00Q+4+2gci/ND/FXULs483IF5610X1vOE22fbrTeZ5u16eJ+SsYZcMGK4k+WkaBbv2kujv+sTGh7DztwhreyYHK1g8g+qGWD5DoD56NxXC5acaNv9lLOClV3ukWbLDQbKsk2mQmUQk6+Xb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743669991; c=relaxed/simple;
	bh=OAUpskNDlEMdIjdcsmy2MVzHDre7qQyW3PzLtSWjU8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgPja0sGUzwoEyB5LlYFyGw9qEcWvwGZr6nd2i6/hEAeU+eWM0IcmjlAadCj769jMqyfZd0L5IJbLLWDEE7U3xo37qsF6RUCshdBZFOcE31YZnAPRpjMRZL7m4VbkVv66YemYMXn7tgmbVsWU2bIiOtxGXwnJV3iMmCTvwXQXGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=csEhzXPp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="csEhzXPp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7AE9C4CEE3;
	Thu,  3 Apr 2025 08:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743669990;
	bh=OAUpskNDlEMdIjdcsmy2MVzHDre7qQyW3PzLtSWjU8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=csEhzXPpHgKuamGzB2VOK4eFwOKB2HCIk7PEtqRLg8RzqL7lJpfrwwX92gf9tjW9Y
	 GDM9OaGF8XeeX0wTe8A13UpY8BwPNGycNIP+IWDE2qOMJ/WmzP56gvNf1NootvsSNj
	 5PbyQAicGYCN3rZ4GMDpCf9gFfESy6vq+0dilt/M=
Date: Thu, 3 Apr 2025 09:45:02 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: xiaopeitux@foxmail.com
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, Pei Xiao <xiaopei01@kylinos.cn>
Subject: Re: [PATCH] tty/sysrq: make sysrq_replay_logs_op const
Message-ID: <2025040349-antiques-reflex-30c5@gregkh>
References: <tencent_E7CD9DB87A448073E350F9400678ED9F9C0A@qq.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_E7CD9DB87A448073E350F9400678ED9F9C0A@qq.com>

On Thu, Apr 03, 2025 at 04:38:18PM +0800, xiaopeitux@foxmail.com wrote:
> From: Pei Xiao <xiaopei01@kylinos.cn>
> 
> Mark sysrq_replay_logs_op as const, preventing accidental modification.
> 
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
>  drivers/tty/sysrq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index f85ce02e4725..e9ada1c14e26 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -454,7 +454,7 @@ static void sysrq_handle_replay_logs(u8 key)
>  {
>  	console_try_replay_all();
>  }
> -static struct sysrq_key_op sysrq_replay_logs_op = {
> +static const struct sysrq_key_op sysrq_replay_logs_op = {
>  	.handler        = sysrq_handle_replay_logs,
>  	.help_msg       = "replay-kernel-logs(R)",
>  	.action_msg     = "Replay kernel logs on consoles",
> -- 
> 2.25.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
