From: Gabriel Paubert <paubert@iram.es>
Subject: Re: [PATCH v3 2/5] firmware: annotate thou shalt not request fw on
 init or probe
Date: Wed, 24 Aug 2016 10:17:38 +0200
Message-ID: <20160824081738.GA8991@visitor2.iram.es>
References: <1466117661-22075-1-git-send-email-mcgrof@kernel.org>
 <1471999507-913-1-git-send-email-mcgrof@kernel.org>
 <1471999507-913-3-git-send-email-mcgrof@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <1471999507-913-3-git-send-email-mcgrof@kernel.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: mcgrof@kernel.org
Cc: Kevin Cernekee <cernekee@gmail.com>, Gilles.Muller@lip6.fr, tiwai@suse.de, Daniel Vetter <daniel.vetter@ffwll.ch>, ming.lei@canonical.com, stephen.boyd@linaro.org, bjorn.andersson@linaro.org, teg@jklm.no, chunkeey@googlemail.com, cocci@systeme.lip6.fr, jwboyer@fedoraproject.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, torvalds@linux-foundation.org, Thierry Martinez <martinez@nsup.org>, linux-serial@vger.kernel.org, jslaby@suse.com, zohar@linux.vnet.ibm.com, Alessandro Rubini <rubini@gnudd.com>, arend.vanspriel@broadcom.com, Kees Cook <keescook@chromium.org>, hauke@hauke-m.de, markivx@codeaurora.org, nicolas.palix@imag.fr, Abhay_Salunke@dell.com, Julia.Lawall@lip6.fr, broonie@kernel.org, j.anaszewski@samsung.com, kvalo@codeaurora.org, dhowells@redhat.com, fengguang.wu@intel.com, gregkh@linuxfoundation.org, dmitry.torokhov@gmail.com, daniel.wagner@bmw-c
List-Id: linux-serial@vger.kernel.org

On Tue, Aug 23, 2016 at 05:45:04PM -0700, mcgrof@kernel.org wrote:

[snip]
> ---
>  Documentation/firmware_class/README                |  20 ++++
>  drivers/base/Kconfig                               |   2 +-
>  .../request_firmware-avoid-init-probe-init.cocci   | 130 +++++++++++++++++++++
>  3 files changed, 151 insertions(+), 1 deletion(-)
>  create mode 100644 scripts/coccinelle/api/request_firmware-avoid-init-probe-init.cocci
> 
> diff --git a/Documentation/firmware_class/README b/Documentation/firmware_class/README
> index cafdca8b3b15..056d1cb9d365 100644
> --- a/Documentation/firmware_class/README
> +++ b/Documentation/firmware_class/README
> @@ -93,6 +93,26 @@
>     user contexts to request firmware asynchronously, but can't be called
>     in atomic contexts.
>  
> +Requirements:
> +=============
> +
> +You should avoid at all costs requesting firmware on both init and probe paths
> +of your device driver. Reason for this is the complexity needed to ensure a
> +firmware will be available for a driver early in boot through different
> +build configurations. Consider built-in drivers needing firmware early, or
> +consider a driver assuming it will only get firmware after pivot_root().
> +
> +Drivers that really need firmware early should use stuff the firmware in

Minor grammatical nit: s/use//

> +initramfs or consider using CONFIG_EXTRA_FIRMWARE. Using initramfs is much
> +more portable to more distributions as not all distributions wish to enable
> +CONFIG_EXTRA_FIRMWARE. Should a driver require the firmware being built-in
> +it should depend on CONFIG_EXTRA_FIRMWARE. There is no current annotation for
> +requiring a firmware on initramfs.
> +
> +If you're a maintainer you can help police this with:
> +
> +$ export COCCI=scripts/coccinelle/api/request_firmware-avoid-init-probe-init.cocci
> +$ make coccicheck MODE=report
>  
>   about in-kernel persistence:
>   ---------------------------
