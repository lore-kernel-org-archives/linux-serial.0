Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A895851008;
	Thu, 30 Nov 2023 14:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VcFOBmHf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958A7C433C7;
	Thu, 30 Nov 2023 14:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701355342;
	bh=1evN051Mbh6OY0NI4nMnhMwsEcmX/E7ST4nOGq8Lvuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VcFOBmHfLdbvFIb/JAbIf+Bqy+VQHfIM3cZ2cbvYnkdQHOgPQFAQIO7O2ky1TAZqV
	 cA1vQkY86wO+KGz/HOlL8Eaz2gYcqNmLK0VBnq/oqoDHWey0NjHlq/rhoX6/ECwM+4
	 rZ0++KeOOY29PVdNNCDw7LC06kGaa7xyztbYprKU=
Date: Thu, 30 Nov 2023 14:42:20 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Oliver Neukum <oneukum@suse.com>
Cc: Johan Hovold <johan@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	USB list <linux-usb@vger.kernel.org>, linux-serial@vger.kernel.org
Subject: Re: question on correct error return from break_ctl()
Message-ID: <2023113053-oxidize-observant-9fb8@gregkh>
References: <7e649033-0e1d-4c21-a1f3-ceb2de894861@suse.com>
 <2023113055-molecular-backlands-6b3d@gregkh>
 <0dd783e9-1cd2-467f-a90d-e63fec88350c@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dd783e9-1cd2-467f-a90d-e63fec88350c@suse.com>

On Thu, Nov 30, 2023 at 03:36:21PM +0100, Oliver Neukum wrote:
> On 30.11.23 14:48, Greg Kroah-Hartman wrote:
> Hi,
> 
> > usb-serial should probably change, but given the fact that no one has
> > noticed this in the 20+ years it has been like this, is it really
> > needed?  :)
> 
> I am afraid I need to point out that usb-serial has been changed _this_ _year_
> to return -ENOTTY. CDC-ACM being also in this situation unfortunately
> I need to decide between one of the alternatives.

Ah, oops, then it should probably be changed back.  Unless Johan, any
specific reason this was changed?

thanks,

greg k-h
