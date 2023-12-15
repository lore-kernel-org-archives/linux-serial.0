Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEAB1A700
	for <linux-serial@vger.kernel.org>; Fri, 15 Dec 2023 10:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XCBCApsN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25578C433C8;
	Fri, 15 Dec 2023 10:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702636715;
	bh=YmBL969lL4xv4gCrjQpT4qJtSeCOTkJH8QP60MbUke4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XCBCApsNUpldI9h3r4HUp6Yl4EieMgBzxHkdy3xekr8yANc4VOEoFMA0zzofH8NXj
	 toO1hf2rj2eMuJAGvjQEOlYYDnQeyKO4qXx1Cq5YpX8c1KYHJN6NJud73GxlEko/Qp
	 /OVVZUcP05ySAIJAVkeekOK+A3e0Gbb1rFXOCuSo=
Date: Fri, 15 Dec 2023 11:38:32 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: quic_zijuhu <quic_zijuhu@quicinc.com>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v1] tty: Fix a security issue related to tty-ldisc module
 loading
Message-ID: <2023121514-likely-sequester-050b@gregkh>
References: <1702628933-6070-1-git-send-email-quic_zijuhu@quicinc.com>
 <2023121530-crept-unisexual-de76@gregkh>
 <38ca1fa8-5631-4511-8962-31c8948e19b8@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38ca1fa8-5631-4511-8962-31c8948e19b8@quicinc.com>

On Fri, Dec 15, 2023 at 05:32:52PM +0800, quic_zijuhu wrote:
> On 12/15/2023 4:43 PM, Greg KH wrote:
> > On Fri, Dec 15, 2023 at 04:28:53PM +0800, Zijun Hu wrote:
> >> Function tty_ldisc_get() has a simple logical error and may cause tty-ldisc
> >> module to be loaded by a user without CAP_SYS_MODULE, this security issue
> >> is fixed by correcting the logical error.
> > 
> > What specific security issue are you referring to here?
> module tty-ldisc is able to be loaded by a user who don't have relevant permission CAP_SYS_MODULE to load module.

Yes, that is as-intended, why are you trying to break existing
functionality that has been present for forever?

> current logical is weird and it confuse me as a tty driver beginner since the intuitive checking is shown by my change.

It might be confusing, but it is correct.  You have to justify changing
existing functionality a lot, especially for user-visable stuff like
this.

And to say it is a "security issue" is not correct, it is this way by
design, please work to understand history before attempting to change it
for no documented reason.  Did you read the config option that helps
control this functionality?  Did the help text there not explain it
properly?  If so, please provide additional documentation where needed.

I suggest working with others at your company that have more experience
before submitting changes like this in the future, as they should be
able to help you out better instead of relying on the community to do
so.

thanks,

greg k-h
