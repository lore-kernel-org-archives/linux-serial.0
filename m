Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EF2469834;
	Thu, 30 Jul 2026 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428436; cv=none; b=JwwpCNo5vMRv6nqcU/iZi9I0n+EJr5s6yRQb/vXBhwd9pA6BfKDfFRfgueoKenugYG/RTLI955cHwF03aYriLKm8HnMgqs/ZI9hFMWRt5DMouUQSlykMbdo6UNNm3DhHJUlWT8HXcIzyDv8Kctp9/xkunYpwDjp4BPEfFw/Tnvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428436; c=relaxed/simple;
	bh=A4/1tW7h6zxlQBWRUA6+Wqi1bzSlxLg8MltiLeRi83s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hj26vf+bNC0d4hXyzosD9WbrqkWsWWKJtEYfv6PW2CgLbmaWwimAgkw0p22ifNmfeTQaFAaTpbbChUyJWBiV8GcFiyz3ztoR89PDENtByJcYwCTtpg3EfuNAJC1jUjGqEk1pSjXEzV+JInC8XW2ZHPW/eumHC9CQNpqZFDFkk90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IWhLp4u2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IWhLp4u2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584171F000E9;
	Thu, 30 Jul 2026 16:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785428434;
	bh=+iuGoat9AdxQzu1rkzKWJvdxdqSaBy046101iklSDi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IWhLp4u2N6DG8voIA3Bvg3NayfUCwAbpGYTNNUeF1wl3agb1mo7JmEc0U1ORVnYmy
	 D0wth+eMaTuJ7owG99/H+H1kdj0ld7T7fcYE6n6Er+TTUt7KUw7LdkhRrXs1zO/D85
	 P+Bs6i6gbQcpluy3VzvQEspD2YCQ466SF0/vsVSY=
Date: Thu, 30 Jul 2026 17:00:10 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, konrad.dybcio@oss.qualcomm.com,
	bjorn.andersson@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	chandana.chiluveru@oss.qualcomm.com,
	mukesh.savaliya@oss.qualcomm.com
Subject: Re: [PATCH 0/3] serial: qcom-geni: Reuse common GENI framework
 helpers
Message-ID: <2026073053-gracious-creole-cbaa@gregkh>
References: <20260720-reuse_common_geni_framework_helpers-v1-0-c3330ab9b982@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720-reuse_common_geni_framework_helpers-v1-0-c3330ab9b982@oss.qualcomm.com>

On Mon, Jul 20, 2026 at 08:37:48PM +0530, Praveen Talari wrote:
> The Serial driver currently maintains several helpers that duplicate
> functionality already available in the GENI core, including resource
> initialisation, power-domain attachment, runtime PM resource
> management, and perf-level selection.
> 
> Replace these with common GENI helper APIs for resource initialization,
> runtime PM resource management, and performance-level configuration.  This
> reduces code duplication and centralizes GENI resource handling.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
> Praveen Talari (3):
>       serial: qcom-geni: Use common GENI resource initialisation helpers
>       serial: qcom-geni: Use resources helper APIs in runtime PM functions
>       serial: qcom-geni: Use geni_se_set_perf_level() for baud rate perf level
> 
>  drivers/tty/serial/qcom_geni_serial.c | 204 ++++++----------------------------
>  1 file changed, 34 insertions(+), 170 deletions(-)
> ---
> base-commit: 782f4dbd1794b4f30dc116a7ca42c5962c409be8
> change-id: 20260720-reuse_common_geni_framework_helpers-787081bd61a7
> 
> Best regards,
> --  
> Praveen Talari <praveen.talari@oss.qualcomm.com>
> 

Doesn't apply to my tty-testing branch now, perhaps because I took your
other patch for this driver?

thanks,

greg k-h
