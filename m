From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH 1/2] tty: pl011: Work around QDF2400 E44 stuck BUSY bit
Date: Wed, 8 Feb 2017 08:09:12 -0600
Message-ID: <e16986de-31fa-8d34-05be-aa8a585500d4@codeaurora.org>
References: <20170208005736.18724-1-cov@codeaurora.org>
 <7151be59-000c-d50b-f8f5-5fef0c053d91@arm.com>
 <f9504cde-a87a-ba99-2f72-fc3029ef5fe5@codeaurora.org>
 <20170208133306.GE15459@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170208133306.GE15459@leverpostej>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Mark Salter <msalter@redhat.com>, Mark Langsdorf <mlangsdo@redhat.com>, Jon Masters <jcm@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Neil Leeder <nleeder@codeaurora.org>, linux-doc@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, shankerd@codeaurora.org, Christopher Covington <cov@codeaurora.org>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Mark Rutland wrote:

>> No, only Kryo and Falkor V1 based SOCs have this problem.  Falkor V2
>> will have this fixed.  We intend to revert these fixes after Falkor
>> V1 SOCs are no longer supported.
>
> Supported by whom?

Qualcomm.

> Generally, once something's upstreamed we expect it to remain supported.

The V1 SOCs are technically pre-production, but still in wide use and it will be 
a while before they are all replaced by V2 SOCs.  It's only because of the 
"ugliness" of the erratum and its work-around that we want to git rid of it when 
we can.

Cov is better equipped to answer your other questions.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
