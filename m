From: Christopher Covington <cov@codeaurora.org>
Subject: Re: [PATCH 2/2] tty: pl011: Work around QDF2400 E44 for earlycon
Date: Tue, 14 Feb 2017 18:48:20 -0500
Message-ID: <cb5e44c7-3be2-3b10-d133-aaea72c2a485@codeaurora.org>
References: <20170208005736.18724-1-cov@codeaurora.org>
 <20170208005736.18724-2-cov@codeaurora.org>
 <35007ccc-678d-0e2a-109b-4b5321c4fbff@codeaurora.org>
 <0262b9d0-1fd1-ff56-a7c5-b9ab9dcea9a8@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <0262b9d0-1fd1-ff56-a7c5-b9ab9dcea9a8@codeaurora.org>
Sender: linux-doc-owner@vger.kernel.org
To: shankerd@codeaurora.org, Timur Tabi <timur@codeaurora.org>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Cc: Mark Langsdorf <mlangsdo@redhat.com>, Mark Salter <msalter@redhat.com>, Jon Masters <jcm@redhat.com>, Neil Leeder <nleeder@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

On 02/07/2017 11:31 PM, Shanker Donthineni wrote:
> Hi Cov,
> 
> The same PL011 driver will be used in virtutal machine, make sure
> your changes have no side effects in VM.

Fundamentally, this is the same workaround as has been tested in the qserver
downstream kernel for over a year.

Cheers,
Cov

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code
Aurora Forum, a Linux Foundation Collaborative Project.
