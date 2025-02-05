Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20A22F46;
	Wed,  5 Feb 2025 05:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738733795; cv=none; b=iAuPwHSHZQExrAXLVG8xCoSMMAfSa9x/GwAz3KbhfpFO4tQa1U6i8Elq+7FN52oyBKDFWjfZ2vTif4tQGIvRY8zUlHLzVNcG9YBKEaUH4zRxsKPrM8TkHrkDQnZMrZJs3GM4qL4z2DbdsEBED89PLyFVTWTtIodbSH/J2tzeKLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738733795; c=relaxed/simple;
	bh=B4GbIB5xiMSYB/1OpNNVfAE7AOpoeYrDA2QF08ItPko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2ePJesXJk5BmoAw+azcY92LmKnrxYSZDveMfBEKNB9w3d7hDFeuQbBQXj4cfI+U5Qte7YzPAUG3QiOI5AfL96CzxPpyrU8gitxYl2Q8SFXXHzdrtuzH06Y06wo90rDfMckxSLBzPM01R93GmgMuBU5tFnr5xW8y2CPQYtNAMsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bwmv7RGL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bwmv7RGL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30B5C4CED1;
	Wed,  5 Feb 2025 05:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738733794;
	bh=B4GbIB5xiMSYB/1OpNNVfAE7AOpoeYrDA2QF08ItPko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bwmv7RGLkJBXmRSAwHlF1CBWtqJRoANKU1/VUHzobqB6STG6gpgjrgyhzqlN6jeWe
	 RCaTKyTe4p3abAKfl20cLqjN/VhV1iI8d6KLO9fM3EjIlV3BzqhB3z34JvorxrToy+
	 4SeX21s0QP68s/90Rg5Mg8p0cfYXCw/MGBKl+lKg=
Date: Wed, 5 Feb 2025 06:36:26 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] tty: tty_buffer: Avoid hundreds of
 -Wflex-array-member-not-at-end warnings
Message-ID: <2025020503-unnamable-canopener-ac71@gregkh>
References: <Z6L1XwE-WEzcGFwv@kspp>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6L1XwE-WEzcGFwv@kspp>

On Wed, Feb 05, 2025 at 03:51:35PM +1030, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> So, in order to avoid ending up with a flexible-array member in the
> middle of other structs, we use the `struct_group_tagged()` helper
> to create a new tagged `struct tty_buffer_hdr`. This structure
> groups together all the members of the flexible `struct tty_buffer`
> except the flexible array.
> 
> As a result, the array is effectively separated from the rest of the
> members without modifying the memory layout of the flexible structure.
> We then change the type of the middle struct member currently causing
> trouble from `struct tty_buffer` to `struct tty_buffer_hdr`.
> 
> We also want to ensure that when new members need to be added to the
> flexible structure, they are always included within the newly created
> tagged struct. For this, we use `static_assert()`. This ensures that the
> memory layout for both the flexible structure and the new tagged struct
> is the same after any changes.
> 
> This approach avoids having to implement `struct tty_buffer_hdr` as a
> completely separate structure, thus preventing having to maintain two
> independent but basically identical structures, closing the door to
> potential bugs in the future.

Why not just have a separate structure and embed that in the places it
is used?  No duplication should be needed or am I missing something?

I don't mind that, it would make this all much simpler and more obvious
over time, and the tty layer needs all the "simplification" it can get
:)

thanks,

greg k-h
