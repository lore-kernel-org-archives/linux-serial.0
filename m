From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [RFC 0/5] console/acpi: add DBG2 and SPCR console configuration
Date: Wed, 23 Sep 2015 15:38:20 +0800
Message-ID: <CACVXFVPEJb-RXLgU0V+HduoENquUs3oDGWsUtCvH+TOSRMYiUg@mail.gmail.com>
References: <1441716217-23786-1-git-send-email-leif.lindholm@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1441716217-23786-1-git-send-email-leif.lindholm@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Leif Lindholm <leif.lindholm@linaro.org>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-serial@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, al.stone@linaro.org, torez@redhat.com, Jon Masters <jcm@redhat.com>, G Gregory <graeme.gregory@linaro.org>, linaro-acpi@lists.linaro.org, Lv Zheng <lv.zheng@intel.com>
List-Id: linux-serial@vger.kernel.org

Hi Leif,


On Tue, Sep 8, 2015 at 8:43 PM, Leif Lindholm <leif.lindholm@linaro.org> wrote:
> Support for configuring bootconsole and console via the ACPI tables
> DBG2 (Debug Port Table 2) [1] and SPCR (Serial Port Console Redirection
> Table) [2], defined by Microsoft, has been discussed on and off over the
> years.
>
> [1] https://msdn.microsoft.com/en-us/library/windows/hardware/dn639131(v=vs.85).aspx
> [2] https://msdn.microsoft.com/en-us/library/windows/hardware/dn639132(v=vs.85).aspx
>
> Licensing concerns have prevented this happening in the past, but as of
> 10 August 2015, these tables have both been released also under OWF 1.0
> (http://www.openwebfoundation.org/legal/the-owf-1-0-agreements/owfa-1-0)
> which is think is noncontroversially GPL-compatible?
>
> This set is a first attempt at implementing this.

>From distribution view, the patchset looks very useful.

I have one simple question, are there other candidates for conveying this kind
of information like what DBG2/SPCR does? Or are DBG2 and SPCR the
offical speficiations to do such things in ARM server industry?

Thanks,
