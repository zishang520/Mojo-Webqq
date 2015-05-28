sub Mojo::Webqq::Model::_get_discuss_list_info {
    my $self = shift;
    my $api_url = 'http://s.web2.qq.com/api/get_discus_list';   
    my @query_string = (
        clientid    =>  $self->clientid,
        psessionid  =>  $self->psessionid,
        vfwebqq     =>  $self->vfwebqq,
        t           =>  time(),
    );
     
    my $headers = {
        Referer  => 'http://s.web2.qq.com/proxy.html?v=20130916001&callback=1&id=1',
        json     => 1,
    };
    my $json = $self->http_get($self->gen_url($api_url,@query_string),$headers);
    $json = {} unless defined $json;
    return undef if $json->{retcode}!=0;  
    for(@{ $json->{result}{dnamelist} }){
        $_->{dname} = delete $_->{name};
        $_->{downer} = delete $_->{owner};
        $self->reform_hash($_);
    } 
    return $json->{result}{dnamelist};
}

1;
