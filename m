From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH 1/2] tty: pl011: Work around QDF2400 E44 stuck BUSY bit
Date: Wed, 8 Feb 2017 10:07:50 -0600
Message-ID: <f1879b37-995b-18ad-18d9-d88a41ef10c7@codeaurora.org>
References: <20170208005736.18724-1-cov@codeaurora.org>
 <7151be59-000c-d50b-f8f5-5fef0c053d91@arm.com>
 <f9504cde-a87a-ba99-2f72-fc3029ef5fe5@codeaurora.org>
 <20170208133306.GE15459@leverpostej>
 <e16986de-31fa-8d34-05be-aa8a585500d4@codeaurora.org>
 <87lgtg7l1c.fsf@on-the-bus.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87lgtg7l1c.fsf@on-the-bus.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Mark Salter <msalter@redhat.com>, Mark Langsdorf <mlangsdo@redhat.com>, Jon Masters <jcm@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Neil Leeder <nleeder@codeaurora.org>, linux-doc@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, shankerd@codeaurora.org, Christopher Covington <cov@codeaurora.org>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 02/08/2017 09:35 AM, Marc Zyngier wrote:
> Interesting. How will you guarantee that nobody will ever want to run a
> mainline kernel on this box after a certain date? Self-destruct timer?
> ;-)
>
> As someone who runs mainline on HW that exceeded its "sell-by" date by a
> few decades, I'm genuinely interested.

The affected chips are pre-production and are only available to select 
customers for a limited time.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
