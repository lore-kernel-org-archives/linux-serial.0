Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CF441F7E9;
	Fri, 10 Jul 2026 12:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783687291; cv=none; b=AiDsmGLBu2cMh0jI6Wm8E8O0GuyMO9+tvrJaVnq7t7/p6l+cZpfpgfb1hlaTYV0Wd7wj6v0RNOFKzfyQBtpgAc3rqxbRCN3zChKXpIEeTspAMj1rmokVveE0tmLZQKgjN/2CzmrEwjkRbCrwygz8XFMdVQc0RiEXEbzCMFNPGR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783687291; c=relaxed/simple;
	bh=EE3TjfG5eBu9Kd/+X8PmMovB9kNi9gsUzWBASrpUxJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZCzk2O0JMKJD++b3poocO5HslT63b5/iz6Qq/iG8G8DlFLXrUymUsvdATjfnBeFX31SZ5L3BaYgyNxSfngohU2dpu1D0qKgOE063sCRUnahyXMey7UV7i+e3hwsSHnNKUtS9WiKksY4+YmjxzsRBn6A9mpk9lE3i4uI5ZhwpDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wiaptpKI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wiaptpKI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7A61F000E9;
	Fri, 10 Jul 2026 12:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783687289;
	bh=hDRYjbEaGoQ0tWoMPUac6jeuxz0p0lipsR0FrMDOr4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=wiaptpKIaT2vKbCT97Xw1lAzPN97jTJ7LbV6tqRp67jzEMDgFgq30g/xXN7ILSxyy
	 Rg79dR3+x86n6Ikq3v85BLbHXFwdzzK68+Y5U52/KhKzspCYBSa/OI0w69KsCbJFOg
	 4mtV7UUdjdoZ36eI2aZaQEtKh5KhS0xygKPCyjVM=
Date: Fri, 10 Jul 2026 14:41:25 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jiri Slaby <jirislaby@kernel.org>, konrad.dybcio@oss.qualcomm.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
	mukesh.savaliya@oss.qualcomm.com, aniket.randive@oss.qualcomm.com,
	chandana.chiluveru@oss.qualcomm.com
Subject: Re: [PATCH v5 2/2] serial: qcom-geni: Add tracepoints for Qualcomm
 GENI serial driver
Message-ID: <2026071015-empower-sandpit-97a8@gregkh>
References: <20260615-add-tracepoints-for-qcom-geni-serial-v5-0-2efa4c97e0e2@oss.qualcomm.com>
 <20260615-add-tracepoints-for-qcom-geni-serial-v5-2-2efa4c97e0e2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615-add-tracepoints-for-qcom-geni-serial-v5-2-2efa4c97e0e2@oss.qualcomm.com>

On Mon, Jun 15, 2026 at 07:46:53PM +0530, Praveen Talari wrote:
> Add tracing to the Qualcomm GENI serial driver to improve runtime
> observability.
> 
> Trace hooks are added at key points including termios and clock
> configuration, manual control get/set, interrupt handling, and data
> TX/RX paths.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
> v2->v3:
> - Updated commit text(removed example as it was available on cover
>   letter).
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)

Does not apply to my tty-next branch :(
