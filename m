Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995A518B1B
	for <linux-serial@vger.kernel.org>; Fri, 12 Apr 2024 05:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712899029; cv=none; b=b1ZJANUzCI/10BtksFxrHithie96OjOTMbysBxtV1dugDVCAzXqMztCRMuHLKUD2hzkiaYdHGGkEFqyCCgRc+XMbRgCDbD/RBWr1wMsWGY5tReaxMFVbx0q64HTCj4lMm4k+sED9UGL3e+hZnt+Lug2yCNEK8FkjLp2lyHRD1mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712899029; c=relaxed/simple;
	bh=5ObttNoUoP5pfXkDqVhw5z9ktTzH3YDdpkyV3kIra9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jo2NjjsES18OrQJpODlao91+Sa1DGHO6UwBZo8OKqJ9J5YgiE8N1c067+p88jqODmieY1aHtPVrTS95PH45qwyNzjP5he7UeqEskC/tOrHfDkp9BnC6v4Ygl7/Zqe0OvNKJK20+6afeQTeD9DjsgCUyvrTgl/RyeOm5be+KRaEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ESn2Sqdn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ESn2Sqdn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0BDC2BBFC;
	Fri, 12 Apr 2024 05:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712899029;
	bh=5ObttNoUoP5pfXkDqVhw5z9ktTzH3YDdpkyV3kIra9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ESn2SqdnZ67NabWjIyjMXMmJ5bJ2978DZkKSr6UkYeNTB494mulyZgNELuZQAjLBb
	 4MP9ZVM0GMH+Ohp5epfGQ2qqFL/Pc8pvFNuuIG6/tHF2zZNbPaEjmYMNlfJGkn9yov
	 fSb5Uk6hlhCmXGzuxFZHUK9zRY4n38DaY8HnN0tI=
Date: Fri, 12 Apr 2024 07:17:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Daniel Starke <daniel.starke@siemens.com>
Cc: linux-serial@vger.kernel.org, jirislaby@kernel.org
Subject: Re: [Bug 218708] New: Off-by-one vulnerability when reading data
 from the n_gsm module
Message-ID: <2024041208-curtly-wolverine-349e@gregkh>
References: <bug-218708-208349@https.bugzilla.kernel.org/>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-218708-208349@https.bugzilla.kernel.org/>

Daniel, can you take a look at the bugzilla report below?  There is lots
of "chatter" about the n_gsm code right now for obvious reasons, and I
have reports that there is at least one outstanding bug in the codebase
that can be triggered by userspace, perhaps this is that issue?

If not looking at it either way would be great if you could, thanks!

greg k-h

On Thu, Apr 11, 2024 at 01:56:38AM +0000, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=218708
> 
>             Bug ID: 218708
>            Summary: Off-by-one vulnerability when reading data from the
>                     n_gsm module
>            Product: Linux
>            Version: unspecified
>           Hardware: All
>                 OS: Linux
>             Status: NEW
>           Severity: high
>           Priority: P3
>          Component: Kernel
>           Assignee: linux-kernel@kernel-bugs.kernel.org
>           Reporter: j51569436@gmail.com
>                 CC: gregkh@linuxfoundation.org
>         Regression: No
> 
> An off-by-one vulnerability occurs in gsm0_receive and gsm1_receive. I'll focus
> on gsm0_receive for our discussion.
> 
> 
> [1] : Write the value to gsm->buf, then increment gsm->count by 1. 
> [2] : If gsm->count == gsm->len is reached, stop reading. 
> 
> 
> Writing a value to a buffer and then checking its length is typical of
> off-by-one vulnerabilities. 
> 
> ```c
> static void gsm0_receive(struct gsm_mux *gsm, u8 c)
> {
>         unsigned int len;
> 
>         switch (gsm->state) {
> ...
>         case GSM_DATA:          /* Data */
>                 gsm->buf[gsm->count++] = c;//[1]
>                 if (gsm->count == gsm->len) {//[2]
>                         /* Calculate final FCS for UI frames over all data */
>                         if ((gsm->control & ~PF) != UIH) {
>                                 gsm->fcs = gsm_fcs_add_block(gsm->fcs,
> gsm->buf,
>                                                              gsm->count);
>                         }
>                         gsm->state = GSM_FCS;
>                 }
>                 break;
>         case GSM_FCS:           /* FCS follows the packet */
>                 gsm->fcs = gsm_fcs_add(gsm->fcs, c);
>                 gsm->state = GSM_SSOF;
>                 break;
>         case GSM_SSOF:
>                 gsm->state = GSM_SEARCH;
>                 if (c == GSM0_SOF)
>                         gsm_queue(gsm);
>                 else
>                         gsm->bad_size++;
>                 break;
>         default:
>                 pr_debug("%s: unhandled state: %d
> ", __func__, gsm->state);
>                 break;
>         }
> }
> ```
> 
> - `gsm->count == gsm->len` should be changed to `(gsm->count+1) == gsm->len`
> 
> -- 
> You may reply to this email to add a comment.
> 
> You are receiving this mail because:
> You are on the CC list for the bug.
