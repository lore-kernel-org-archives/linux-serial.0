Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8C22C851
	for <linux-serial@vger.kernel.org>; Fri, 15 Dec 2023 12:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iWe25sfD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E41D5C433C8;
	Fri, 15 Dec 2023 12:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702642641;
	bh=Co53JwG86duqIasQQEJqk9Nl6xsOiUgLo+mKnnJ9otA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iWe25sfDVhK8DFgNfDvbrusRn4t/CuilN8j86WFfes2JOUrhqCIsqGS7a0ct/45qc
	 WZ/Ii5FVuKCx3RXc+XczTWfQVWt3ngpGjm2MUiCfwHbdapm81o2UptI3JrnaVQIx7k
	 fshWldbFwQMKzyLNyw6gc52aJx5NDHOskFcei+Is=
Date: Fri, 15 Dec 2023 13:17:18 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v1] tty: Make tty-ldisc module loading logic easy to
 understand
Message-ID: <2023121502-chewer-alto-dba4@gregkh>
References: <1702640236-22824-1-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1702640236-22824-1-git-send-email-quic_zijuhu@quicinc.com>

On Fri, Dec 15, 2023 at 07:37:16PM +0800, Zijun Hu wrote:
> Current tty-ldisc module loading logic within tty_ldisc_get()
> is prone to mislead beginner that the module is able to be loaded
> by a user without capability CAP_SYS_MODULE, add comments and
> optimize the logic to make it easy to undertand.

You did not "optimize" anything here, you just:

> -		if (!capable(CAP_SYS_MODULE) && !tty_ldisc_autoload)
> +		if (!tty_ldisc_autoload && !capable(CAP_SYS_MODULE))

Switched the operands around, not really doing anything at all to make
it "easier" to understand, sorry.

Again, please go work with developers at:

> The Qualcomm Innovation Center

To come up with a better change and get them to sign-off on the change
before resubmitting it to us for review.

thanks,

greg k-h
