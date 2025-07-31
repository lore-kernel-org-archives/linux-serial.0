Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DBF1C32;
	Thu, 31 Jul 2025 14:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753973441; cv=none; b=myw6iEeM/vVvlZlk9eVdWjH9fE4E7FikCyrjMLW9sdzIBLYKBtX3s7/2JjifyM2lIcrQZj22wt1nVVuRwOxHVvoPLrwzqqCWvuwENZ+b+RNeBgoxBDoNVX8uhmdz+2lNWQzIRkDol5rl6BEqe23v93kjyhFYFVbOF38i1A4BTBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753973441; c=relaxed/simple;
	bh=59ORGAr6ovkMQGwC2Cazcbgxoh/EgJHZ28I5Xyko6c4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XvhggAC8YJ0VfRsMZva2bdccFSreepiB5SDpzjPYzTyMgmb+4YtY1kDWBXMOWjqivFNbRGD9bCRUOwAwN84MidBrMZ8b9RETPmw+MfyvsXwAmPd8maKDjCIGbPzLobniGQpqD7Kx358BgrfM7YIFHjR7l6FBGgCL1lZ6MEDea/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4btBbW4VT3z9v8v;
	Thu, 31 Jul 2025 16:41:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3AjqPM4-m4E9; Thu, 31 Jul 2025 16:41:11 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4btBbW3qXxz9v8b;
	Thu, 31 Jul 2025 16:41:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 7EA788B76E;
	Thu, 31 Jul 2025 16:41:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id W1biCCLjoL8I; Thu, 31 Jul 2025 16:41:11 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 251058B763;
	Thu, 31 Jul 2025 16:41:11 +0200 (CEST)
Message-ID: <3ac7427b-4f17-480e-99ae-f00e5c00e678@csgroup.eu>
Date: Thu, 31 Jul 2025 16:41:10 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/33] tty: vt: use _IO() to define ioctl numbers
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, gregkh@linuxfoundation.org,
 Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nicolas Pitre <nico@fluxnic.net>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <20250611100319.186924-1-jirislaby@kernel.org>
 <20250611100319.186924-8-jirislaby@kernel.org>
 <97ec2636-915a-498c-903b-d66957420d21@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <97ec2636-915a-498c-903b-d66957420d21@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 31/07/2025 à 16:35, Christophe Leroy a écrit :
> Hi Jiri,
> 
> Le 11/06/2025 à 12:02, Jiri Slaby (SUSE) a écrit :
>> _IO*() is the proper way of defining ioctl numbers. All these vt numbers
>> were synthetically built up the same way the _IO() macro does.
>>
>> So instead of implicit hex numbers, use _IO() properly.
>>
>> To not change the pre-existing numbers, use only _IO() (and not _IOR()
>> or _IOW()). The latter would change the numbers indeed.
> 
> On powerpc your assumption is wrong, because _IOC_NONE is not 0:
> 
> $ git grep _IOC_NONE arch/powerpc/
> arch/powerpc/include/uapi/asm/ioctl.h:#define _IOC_NONE 1U
> 
> Therefore the value changes even with _IO(), leading to failure of Xorg 
> as reported by Christian.
> 

And is likely an issue on the 4 following architectures:

$ git grep _IOC_NONE arch/ | grep 1U
arch/alpha/include/uapi/asm/ioctl.h:#define _IOC_NONE	1U
arch/mips/include/uapi/asm/ioctl.h:#define _IOC_NONE	1U
arch/powerpc/include/uapi/asm/ioctl.h:#define _IOC_NONE	1U
arch/sparc/include/uapi/asm/ioctl.h:#define _IOC_NONE        1U


Christophe

