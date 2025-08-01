Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F405E1FA15E;
	Fri,  1 Aug 2025 07:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754033926; cv=none; b=cLhDi1xOeMfXZ858ulC+XSgxBOLyEns6VtT0PGXgmDqcB4WfBZ2s+KU1c5ipdekxU64jAkDCSWuXYEsbtR1Bbyard1WccVO8+NhgXCRI2ffFXU2n3e5q3ZWXumzTY493UNPQ5Hf0PwiR2digkyrzQOjsr23xLVowe3yOm43wfOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754033926; c=relaxed/simple;
	bh=PGUIRkQTVwA/le+QGrm+xXgoYbD5Hwb7ARZOJhCTUJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpETpIpSxyO3YuZXN3RCgNNIKKuVDzBbxd9gNBKA/nw6l0Vs+ff5Rs11ZjZwt0gqsuYJcmnJwbeHABwb6s0/X3pml9bnsOgerbOzUyGyzdTGCeTPTUQK8KdLnXxKGHkmss5i3FNIj3F25LfVdZSUigdyGXbxaHSxDOh5wOvO3N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kADqky8g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kADqky8g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE49C4CEEB;
	Fri,  1 Aug 2025 07:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754033925;
	bh=PGUIRkQTVwA/le+QGrm+xXgoYbD5Hwb7ARZOJhCTUJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kADqky8gvcxY6epOpgG69Fh5ZSLGWCnPR8IP7Nu0nJ79F8bWPF9g8IUg5+NLRYSnS
	 Cz1mhBc/XQOnxI1VRfZSWsIbnevqc786bZUZoUXKFQFGgp7alvnL61D/w9RgJDIwKf
	 3qK664gbomcBtx/mddK3nx5NiIO9LO6iDlTjVJyI=
Date: Fri, 1 Aug 2025 09:38:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Christian Zigotzky <chzigotzky@xenosoft.de>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 07/33] tty: vt: use _IO() to define ioctl numbers
Message-ID: <2025080127-scarf-tableful-dc90@gregkh>
References: <20250611100319.186924-1-jirislaby@kernel.org>
 <20250611100319.186924-8-jirislaby@kernel.org>
 <97ec2636-915a-498c-903b-d66957420d21@csgroup.eu>
 <3ac7427b-4f17-480e-99ae-f00e5c00e678@csgroup.eu>
 <9811012p-4q9q-284q-n2qr-7597s16p8sq5@syhkavp.arg>
 <9fffb5be-eced-4207-86fc-8939de1ab16e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9fffb5be-eced-4207-86fc-8939de1ab16e@kernel.org>

On Fri, Aug 01, 2025 at 06:47:46AM +0200, Jiri Slaby wrote:
> On 31. 07. 25, 22:58, Nicolas Pitre wrote:
> > On Thu, 31 Jul 2025, Christophe Leroy wrote:
> > 
> > > 
> > > 
> > > Le 31/07/2025 à 16:35, Christophe Leroy a écrit :
> > > > Hi Jiri,
> > > > 
> > > > Le 11/06/2025 à 12:02, Jiri Slaby (SUSE) a écrit :
> > > > > _IO*() is the proper way of defining ioctl numbers. All these vt numbers
> > > > > were synthetically built up the same way the _IO() macro does.
> > > > > 
> > > > > So instead of implicit hex numbers, use _IO() properly.
> > > > > 
> > > > > To not change the pre-existing numbers, use only _IO() (and not _IOR()
> > > > > or _IOW()). The latter would change the numbers indeed.
> > > > 
> > > > On powerpc your assumption is wrong, because _IOC_NONE is not 0:
> > > > 
> > > > $ git grep _IOC_NONE arch/powerpc/
> > > > arch/powerpc/include/uapi/asm/ioctl.h:#define _IOC_NONE 1U
> > > > 
> > > > Therefore the value changes even with _IO(), leading to failure of Xorg as
> > > > reported by Christian.
> > > > 
> > > 
> > > And is likely an issue on the 4 following architectures:
> > > 
> > > $ git grep _IOC_NONE arch/ | grep 1U
> > > arch/alpha/include/uapi/asm/ioctl.h:#define _IOC_NONE	1U
> > > arch/mips/include/uapi/asm/ioctl.h:#define _IOC_NONE	1U
> > > arch/powerpc/include/uapi/asm/ioctl.h:#define _IOC_NONE	1U
> > > arch/sparc/include/uapi/asm/ioctl.h:#define _IOC_NONE        1U
> > 
> > IMHO this one patch could simply be reverted and the "old" code let be.
> 
> Oh, right -- it's easy to revert (no conflicts).
> 
> We could use _IOC(0, 'V', number, 0) directly, but I am not sure, that's
> worth it.

Great, can someone send me a revert?

thanks,

greg k-h
