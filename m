Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3047224D5;
	Mon, 17 Jun 2024 05:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718600441; cv=none; b=gmbjpz1leqnbl2T6OfGV8JtYnC4om5rSNsp+QFmtj88/LFSdMGHi9uNn2GPhnUM0VtLE3f2MqdUwVT3IuirxcuI3/kiqytx5fC7ku+XzH7NdqceR+o0Zpy9h6BIrhSz+qiPmHXXCp5n5p4We/5bfBd9EcSQ1lXG3ORrJ/OLaZsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718600441; c=relaxed/simple;
	bh=TiSDGo4GIdTK706kakoXuXG7PIfyfEUJeOtCi7oXKDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpIP2fABKy2nq/0V1plu0AdVM2j0UqKVZ6IAEeI2kwpw73Wsc2X7VkmAEVocCHBjbiHXTPk4CkDaeEZdbWP3mtPg3yL45WvFQz3fWFOQEi9LlJHC8nQqGXgE2fYJKpieXb/P/PIC/b819wK2B4x82Hh4CWxIoGQmltDU7IvhDaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KGl4I0nS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KGl4I0nS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89BAC3277B;
	Mon, 17 Jun 2024 05:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718600440;
	bh=TiSDGo4GIdTK706kakoXuXG7PIfyfEUJeOtCi7oXKDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KGl4I0nSRlqbeOt9SoXZFiYcFfA2u2J8uDlLxD8dUxcXrnYx84B5DvN8pJcovarJR
	 tSNc3YsTUwRTsNqF0PB0BQVYg/9e2B3yb6LoxZZSqmQvLpZEbclg9s6nRiCFP1fbRP
	 89dViiD+rd8kDpY1pZfr7MA5qPqeepnRgNacz24Q=
Date: Mon, 17 Jun 2024 07:00:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "COHEN-SCALI Remi (AMPERE)" <remi.cohen-scali@renault.com>
Cc: "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: [LSM/Landlock] Adding ability to sandbox TTYs
Message-ID: <2024061716-pox-pretzel-1ba2@gregkh>
References: <VI1PR05MB67825BD1C2EFCFCBF7521F7ECBC72@VI1PR05MB6782.eurprd05.prod.outlook.com>
 <VI1PR05MB6782D0D70A2A313434013F9ACBCC2@VI1PR05MB6782.eurprd05.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR05MB6782D0D70A2A313434013F9ACBCC2@VI1PR05MB6782.eurprd05.prod.outlook.com>

On Sun, Jun 16, 2024 at 06:02:03PM +0000, COHEN-SCALI Remi (AMPERE) wrote:
> *** This e-mail and any attachments is a confidential correspondence intended only for use of the individual or entity named above. If you are not the intended recipient or the agent responsible for delivering the message to the intended recipient, you are hereby notified that any disclosure, distribution or copying of this communication is strictly prohibited. If you have received this communication in error, please notify the sender by phone or by replying this message, and then delete this message from your system.

Now deleted.
