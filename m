Return-Path: <SRS0=8zSm=4N=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED87FC35E04
	for <linux-serial@archiver.kernel.org>; Tue, 25 Feb 2020 16:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C634F2082F
	for <linux-serial@archiver.kernel.org>; Tue, 25 Feb 2020 16:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582649874;
	bh=iGs0yCx6/yJN2klUo+eH1+d22OPSIaYSFVwynXiSbZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=opdU83B8k5x/w299YyBCr9rR0HXohV5GrqklYk2uBSSI8wy2UgPNwWjj8DrFTlKDE
	 uS3W0dTinYp2KFZqYPrxwHzukPnr/Z57jSglv+20rHba0iVmz3CNKnRdjML4qdxlYv
	 tdOrRIXz9CWdls+eOxngHtpehN3bpbR68bMDqguI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbgBYQ5y (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 25 Feb 2020 11:57:54 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34966 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbgBYQ5y (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 25 Feb 2020 11:57:54 -0500
Received: by mail-oi1-f194.google.com with SMTP id b18so10662oie.2;
        Tue, 25 Feb 2020 08:57:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6ACHzMKOSBk1FuBO6DMA0vB22pVYkOJchRbVTRFy7wc=;
        b=ouSZ4V/DXQQ9ncFyDMiRSFn6QrlYM/9W0omfDOVeWpsbvVLaNdXLbLnVVVk9ZxVx0Z
         DIPdNobyA/brtbE0/G4R8suJJt1vbW0keTz/1YlWEL017wvcvOEgA7UZlm8kAUBXcdGz
         DY57AaGAjjMRJhQ/pDYuQGex6GBGnI4UvxhoVB1lkgtqQKovmFAP3k5D4q+aylBpRwN7
         z/fdwWpw+Y2mvGJMT0cJgEKpqk/FVQUTSAv87X6S+IjISewANIM6UyYaZezBkkZn1siB
         9Ybs+LeqW4zEuzO3So5k7ubMumpW22D8DIiwCEjknpoUfFCQ4QAmvgNOjh3cm8FURPOz
         gPpg==
X-Gm-Message-State: APjAAAX99Cpdf0USlHTR0JxyeqqrsgnqllqIcBQARWe5CJ73473m5x+7
        NaPMkqbZ21PFWlJUibsQrQ==
X-Google-Smtp-Source: APXvYqwCAroWxHCBDIW6Ez+l4uiPOauLqnHGApz7U1x4l+wo5KhnyaAyjioax5zei4S1Mi5WgdWp3g==
X-Received: by 2002:aca:ebcb:: with SMTP id j194mr4456543oih.154.1582649873340;
        Tue, 25 Feb 2020 08:57:53 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j140sm5452376oib.46.2020.02.25.08.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 08:57:52 -0800 (PST)
Received: (nullmailer pid 16625 invoked by uid 1000);
        Tue, 25 Feb 2020 16:57:50 -0000
Date:   Tue, 25 Feb 2020 10:57:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mateusz Holenko <mholenko@antmicro.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, Stafford Horne <shorne@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Filip Kokosinski <fkokosinski@antmicro.com>,
        Pawel Czarnecki <pczarnecki@internships.antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] dt-bindings: soc: document LiteX SoC Controller
  bindings
Message-ID: <20200225165750.GA15779@bogus>
References: <20200225094437.4170502-0-mholenko@antmicro.com>
 <20200225094437.4170502-2-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225094437.4170502-2-mholenko@antmicro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 25 Feb 2020 09:46:45 +0100, Mateusz Holenko wrote:
> From: Pawel Czarnecki <pczarnecki@internships.antmicro.com>
> 
> Add documentation for LiteX SoC Controller bindings.
> 
> Signed-off-by: Pawel Czarnecki <pczarnecki@internships.antmicro.com>
> Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
> ---
> 
> Notes:
>     This commit has been introduced in v3 of the patchset.
> 
>  .../soc/litex/litex,soc_controller.yaml       | 46 +++++++++++++++++++
>  MAINTAINERS                                   |  6 +++
>  2 files changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/litex/litex,soc_controller.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

warning: no schema found in file: Documentation/devicetree/bindings/soc/litex/litex,soc_controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/litex/litex,soc_controller.yaml: ignoring, error parsing file
Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
Traceback (most recent call last):
  File "/usr/local/bin/dt-doc-validate", line 35, in check_doc
    testtree = dtschema.load(filename, line_number=line_number, duplicate_keys=False)
  File "/usr/local/lib/python3.6/dist-packages/dtschema/lib.py", line 513, in load
    return yaml.load(f.read())
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/main.py", line 343, in load
    return constructor.get_single_data()
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 111, in get_single_data
    node = self.composer.get_single_node()
  File "_ruamel_yaml.pyx", line 718, in _ruamel_yaml.CParser.get_single_node
ruamel.yaml.composer.ComposerError: expected a single document in the stream
  in "<unicode string>", line 1, column 1
but found another document
  in "<unicode string>", line 2, column 1

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/usr/local/bin/dt-doc-validate", line 74, in <module>
    ret = check_doc(args.yamldt)
  File "/usr/local/bin/dt-doc-validate", line 40, in check_doc
    print(filename + ":", exc.path[-1], exc.message)
AttributeError: 'ComposerError' object has no attribute 'path'
Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/soc/litex/litex,soc_controller.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/soc/litex/litex,soc_controller.example.dts] Error 1
Makefile:1263: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1243930
Please check and re-submit.
