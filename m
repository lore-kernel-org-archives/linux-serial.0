Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B637286291;
	Wed, 19 Feb 2025 11:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739966024; cv=none; b=s872YN4H3Dfe+xor477vjOosfMynIEUSeIDlf5PRenQzJXdkWkg+AFD8nuMNp12X72eonaMaIAqHRNiCU8/uDj0i9ZRms5Y5yG659bmn1lumgGdwN3hJqGhQRRhf2F2IwTBx52RC8lZBMx4ft+n/spL0JMpz0O3MjbgyeLbNCu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739966024; c=relaxed/simple;
	bh=Utj7piIWwbu70hM8A68HgXRFZKCVcAnHMDJtZzvmCdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0K0Oe8lXoAJ6K76tF9OyN/uuJtClEPSzlYVNx8UN9ajHTDS+k5vEmil/88wEZgIjy3GKnY7ZthA76tbaA9Mb7VXuxupBELNgUv2ZSwN4fVQZp6O3bedn2rCn0Dq+CE/MBgjT0g3tk6uz38+k9yt9YsD/tIlhxA0neFu220+icI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMAA7m2A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMAA7m2A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF78C4CEDD;
	Wed, 19 Feb 2025 11:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739966023;
	bh=Utj7piIWwbu70hM8A68HgXRFZKCVcAnHMDJtZzvmCdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jMAA7m2AGMA9tWRtGSvz74ik22wtPLkxG8xfO/X51Mi467yUoKC4m+gA1JcUXYIm3
	 oc41kG2fzdjurshLeWFVWeGVL8tLxVax4dyf2ml2dQ/9OFBty1dLStiRWePv+wmMyz
	 sI9oyU5FGyvnYHJB/IxkHbbF6fAwG0FWKCgxkRWsnSlikTNAE1z7Uv5/KKhDQZO49u
	 2qJt2UTDslcWxzeHyhhGDEJ2aJADIGV3V5ynFGI28mgkZeW7BQIKvI57EZqeC22MvD
	 3CN3m9w+mvsRv6cSc6U1swfpJsUN7kuahHpIe8B474AGP1UC3T7lNC5pEVZhPnclu9
	 ejm53uo0si4+Q==
Date: Wed, 19 Feb 2025 12:53:39 +0100
From: Alexey Gladkov <legion@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 1/2] tty/vt: Use KVAL instead of use bit operation
Message-ID: <Z7XGQ6muZoXmhJeD@example.org>
References: <cover.1739881707.git.legion@kernel.org>
 <01ee8849ef8dc49c93a77bc4961ad56b9d435b8a.1739881707.git.legion@kernel.org>
 <3d96896d-5bb7-4ae5-a6c9-b586337eaa3f@kernel.org>
 <Z7WjABCTLE4CisKY@example.org>
 <8b2200ea-425d-477d-8463-d49eb1c7a66a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b2200ea-425d-477d-8463-d49eb1c7a66a@kernel.org>

On Wed, Feb 19, 2025 at 10:33:38AM +0100, Jiri Slaby wrote:
> On 19. 02. 25, 10:23, Alexey Gladkov wrote:
> > On Wed, Feb 19, 2025 at 07:24:52AM +0100, Jiri Slaby wrote:
> >> On 18. 02. 25, 13:29, Alexey Gladkov wrote:
> >>> The K_HANDLERS always gets KVAL as an argument. It is better to use the
> >>> KVAL macro itself instead of bit operation.
> >>>
> >>> Signed-off-by: Alexey Gladkov <legion@kernel.org>
> >>> ---
> >>>    drivers/tty/vt/keyboard.c | 4 ++--
> >>>    1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> >>> index 804355da46f5..7df041ac4d5c 100644
> >>> --- a/drivers/tty/vt/keyboard.c
> >>> +++ b/drivers/tty/vt/keyboard.c
> >>> @@ -885,7 +885,7 @@ static void k_shift(struct vc_data *vc, unsigned char value, char up_flag)
> >>>    		if (kbd->kbdmode == VC_UNICODE)
> >>>    			to_utf8(vc, npadch_value);
> >>>    		else
> >>> -			put_queue(vc, npadch_value & 0xff);
> >>> +			put_queue(vc, KVAL(npadch_value));
> >>
> >> While the mask is the same, this is not a kval, right?
> > 
> > I'm pretty sure it's KVAL, but to be honest I don't understand why it is
> > not done for to_utf8() as well. All values passed to to_utf8() must be
> > kval.
> 
> Not at all, it handles multibyte chars.
> 
> > We call to_utf8() in k_unicode, fn_enter (through k_spec), handle_diacr
> > (through k_deadunicode or k_unicode). All K_HANDLERS take KVAL as value.
> 
> Yes, but pass unicode multibyte to to_utf8().
> 
> > If I understand this code correctly, it is more correct to write it like
> > this:
> > 
> > --- a/drivers/tty/vt/keyboard.c
> > +++ b/drivers/tty/vt/keyboard.c
> > @@ -882,10 +882,11 @@ static void k_shift(struct vc_data *vc, unsigned char value, char up_flag)
> > 
> >          /* kludge */
> >          if (up_flag && shift_state != old_state && npadch_active) {
> > +               u32 kval = KVAL(npadch_value);
> >                  if (kbd->kbdmode == VC_UNICODE)
> > -                       to_utf8(vc, npadch_value);
> > +                       to_utf8(vc, kval);
> 
> Definitely not, as you want to pass that multibyte char in.

Ok. So I misunderstood this code. I will remove this change from the next
version.

-- 
Rgrds, legion

