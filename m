Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE5319EED3;
	Wed, 17 Jun 2026 01:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781659567; cv=none; b=WNoncSmAMcmJWwc/atMciX40UrY8TzJ3rdVMNl1zcI3gkvR7VO3sxaDfdEaviIO5SkELUaVWPJz6HaedGb3ClsjmeRmTuwM20CV5fCRTmV6hd0UhIzxb47cwcJE8TwDrYmjyFjRNUOHU4fTDCqpZRLdDgvSsmEwtWIIY/mIdVQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781659567; c=relaxed/simple;
	bh=9Iz1Z7IypgmrijkgAZ1afwYgJ3QL+c+bJ8/gdqZU5Us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozHkAmePdf+v8cD9Re3dw2XOyMa62XjeKEH08RGF9ABVrWl43d9uY01sX6gspPgo4rDk146lZ/ym17vU8ngefmUPk5islKUjoB0grQsz1dnO/58mjqw8xD7rRYGmYE6fsZnEuwzSp8jej88tF9Xg1lE/D7rT230vVleuV/lc5OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uHSXxnmX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uHSXxnmX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751781F000E9;
	Wed, 17 Jun 2026 01:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781659566;
	bh=UERi1rctSLBl8AOjVUs9vcUeRdxnrTXFowVsF4GNOAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=uHSXxnmXMLCQZTDr7DT8nAWp9Dej+Raw6q00XIeqaN/+PIhJlcFz5O327wYUkB+aI
	 uSVFLrPUwX9UJl82T01F09DHQETwtvBg/UNUlGUyL6a2meXSnql9zkPX5/AB+KV5Iu
	 JAwJPOThdYjt/qnatt81GZmmmejFeLS9wo2VNceE=
Date: Wed, 17 Jun 2026 06:54:59 +0530
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Shuah Khan <shuah@kernel.org>,
	"Starke, Daniel" <daniel.starke@siemens.com>,
	Xiang Mei <xmei5@asu.edu>, linux-serial@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] tty: n_gsm: fix gsm_queue() UAF and add a base
 regression test
Message-ID: <2026061722-explode-predator-59f4@gregkh>
References: <20260616173240.3665059-1-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616173240.3665059-1-bestswngs@gmail.com>

On Tue, Jun 16, 2026 at 10:32:38AM -0700, Weiming Shi wrote:
> The receive worker walks gsm->dlci[] without gsm->mutex while a
> concurrent GSMIOC_SETCONF -> gsm_cleanup_mux() frees the DLCIs, so the
> control handlers can dereference a freed gsm_dlci. v1's NULL check only
> narrowed the window; v2 fixes the use-after-free itself.
> 
> The fix pins each DLCI the dispatch dereferences with its existing
> tty_port reference (option 2), so the data path stays lock-free. See the
> patch 1 commit message for details, including why the late destructor
> uses cmpxchg() so it cannot wipe a re-created mux (Daniel's teardown
> concern).

Cool, but wow, that's complex for something that will never actually
happen in a real device :)

So do we want to add that complexity?  if so, why?

Ideally Daniel can verfiy this change is ok as they are the only known
user here.

And thanks for the test patch, but that's just a functional test, while
great to have, and not one that can actually mimic a real device with
its timing constraints, right?

thanks,

greg k-h
